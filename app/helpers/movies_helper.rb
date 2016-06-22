module MoviesHelper

  def formatted_date(date)
    date.strftime("%b %d, %Y")
  end

  def duration_choices
    [['','0,10000'],['Under 90 minutes','0,89'], ['Between 90 and 120 minutes', '90,120'], ['Over 120 minutes', '121,10000']]
  end
      
end
