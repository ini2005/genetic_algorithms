require_relative '../lib/ga'
require_relative 'product_sum_fitness_calc'

class ProductSumProblem


  # CARDS = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,1,2,3,4,5,6,7,8,9,10,11,12,13,14,1,2,3,4,5,6,7,8,9,10,11,12,13,14,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
  # SUM_TARGET = 382
  # PROD_TARGET = 45360

  CARDS = [1,2,3,4,5,6,7,8,9,10]
  SUM_TARGET = 36
  PROD_TARGET = 360

  def self.run

    fitness_calc = ProductSumFitnessCalc.new CARDS, SUM_TARGET, PROD_TARGET

    fittest = GA.run fitness_calc

    sum_cards = []
    sum = 0
    prod_cards = []
    prod = nil

    fittest.genes.each_with_index do |gene, index|

      card = CARDS[index]
      #sum
      if gene == 0

        sum += card
        sum_cards.push card

        #product
      else

        prod = prod * card rescue card
        prod_cards.push card
      end

    end

    prod = prod || 0

    puts "Got sum of: #{sum} with the following cards: #{sum_cards}"
    puts "Got prod of: #{prod} with the following cards: #{prod_cards}"
  end
end

ProductSumProblem.run
