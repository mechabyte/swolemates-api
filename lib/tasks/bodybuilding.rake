require 'open-uri'
require 'nokogiri'

namespace :bodybuilding do

  desc "display the current environment of rake"
  task :scrape => :environment do

    # Base URLs
    puts "Gold star we tryin'"
    start = "http://www.bodybuilding.com/exercises/list/muscle/selected/abdominals"
    base = "http://www.bodybuilding.com/exercises/list/muscle/selected/"
    # Load first page and set muscle var
    page = Nokogiri::HTML( open( start ) )
    #muscles = page.css('div[style="padding-top:10px; padding-bottom:10px; margin-left:5px;"] strong')
    muscles = page.css('ul.muscle-pagination li')
    # Let's do this!
    muscles.each do |muscle|
      muscle_text_pretty = muscle.text
      muscle_text_url = muscle_text_pretty.downcase
      muscle_text_url.gsub! /\s+/, '-'
      puts "Creating " + muscle_text_pretty + " model"
      @muscle = Muscle.new(
        name: muscle_text_pretty.squish,
        description: '',
      )
      @muscle.save

      # Load all exercises on muscle index page
      muscle_exercises_page = Nokogiri::HTML(open String( base + muscle_text_url ) )
      muscle_exercises = muscle_exercises_page.css('#listResults h3 a')
      # Loop through exercises
      muscle_exercises.each do |exercise|
        # Format exercise title
        exercise_name = exercise.text
          exercise_name[0] = ''
          exercise_name[ exercise_name.length - 0 ] = ''
        puts @muscle.name + " << " + exercise_name
        # Load exercise page
        exercise_page = Nokogiri::HTML(open( exercise.attribute('href').value ))
        # Grab exercise rating
        exercise_rating = exercise_page.css('#largeratingwidget span.rating').text.strip
        # Gather exercise steps
        exercise_steps = exercise_page.css('#listing .guideContent ol li')
        @exercise = Exercise.new(
          name: exercise_name.squish,
          description: '',
          muscle_id: @muscle.id,
        )
        @exercise.save

        # Load all steps for this exercise
        exercise_steps.each_with_index do |step,index|
          @step = ExerciseStep.new(
            description: step.text.squish,
            exercise_id: @exercise.id,
            row_order: (index * 10)
          )
          @step.save
        end
      end
    end
  end

end