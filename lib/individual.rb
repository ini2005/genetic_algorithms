class Individual

  attr_accessor :genes


  # Create a random individual
  def initialize(fitness_calc)

    @genes = []
    @fitness = 0
    @fitness_calc = fitness_calc
    (0..fitness_calc.gene_size - 1).each do |i|
      @genes.push Random.rand.round
    end
  end

  def gene_at(index)
    @genes[index]
  end

  def size
    @genes.size
  end

  def set_gene(index, value)
    @genes[index] = value
    @fitness = 0
  end


  def fitness
    if @fitness == 0
      @fitness = @fitness_calc.calc_fitness(@genes)
    end
    return @fitness
  end

  def is_better_than(other_individual)

    my_score = (@fitness_calc.max_fitness - self.fitness).abs
    other_score = (@fitness_calc.max_fitness - other_individual.fitness).abs

    my_score < other_score
  end


end
