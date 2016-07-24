class ProductSumFitnessCalc

  attr_accessor :max_fitness, :gene_size


  def initialize(cards, target_sum, target_product)
    @max_fitness = 0.0
    @cards = cards
    @target_sum = target_sum.to_f
    @target_product = target_product.to_f
    @gene_size = cards.count
  end

  def calc_fitness(genes)

    if genes.size != @cards.count
      raise 'Gene size does not match cards count'
    end

    sum = 0
    product = nil

    genes.each_with_index do |gene, index|

      card = @cards[index]
      #sum
      if gene == 0

        sum += card
        #product
      else

        product = product * card rescue card
      end
    end

    product = product || 0

    fitness = ((sum - @target_sum)/@target_sum).abs + ((product - @target_product)/@target_product).abs

    fitness
  end

  def print_fitness(individual)
    sum_cards = []
    sum = 0
    prod_cards = []
    prod = nil

    individual.genes.each_with_index do |gene, index|

      card = @cards[index]
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
