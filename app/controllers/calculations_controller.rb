class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.gsub(" ","").length

    @word_count = @text.split(" ").length

    @occurrences = @text.downcase.split(" ").count(@special_word.downcase)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
end

def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    periods_per_year = 12
    monthly_rate = @apr/periods_per_year/100
    @monthly_payment = (monthly_rate)*(@principal)/(1-(1+monthly_rate)**(-@years*periods_per_year))

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
end

def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @weeks/(365.25/7)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
end

def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.length

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum

    def median(array)
      sorted = array.sort
      len = sorted.length
      return (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
  end

  @median = median(@numbers)

  @sum = @numbers.inject(:+)

  @mean = @sum / @count

  total_error = 0
  @numbers.each do |value|
   total_error += (value-@mean)**2
end

@variance = total_error / @count

@standard_deviation = @variance**0.5

frequencies = Hash.new

@numbers.each do |value|
    if !frequencies.has_key?(value)
        frequencies[value] = 1
    else
        frequencies[value] += 1
    end
end

freq_keys = frequencies.keys
freq_values = frequencies.values

@mode = frequencies.keys[freq_values.index(freq_values.max)]

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
end
end
