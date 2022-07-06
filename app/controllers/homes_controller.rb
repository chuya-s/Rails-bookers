class HomesController < ApplicationController
  def top
    puts "作成したキー #{ENV['TEST_KEY']}"
  end

  def about
  end
end
