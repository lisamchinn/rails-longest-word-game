module GamesHelper
  def word_in_grid?(attempt, grid)
    h_a = histogramize(attempt)
    h_g = histogramize(grid)
    h_a.all? do |key, value|
      h_g.key?(key) && value <= h_g[key]
    end
  end

  def histogramize(a_string)
    hash = Hash.new(0)
    a_string.downcase.chars.each { |letter| hash[letter] += 1 }
    hash
  end
end
