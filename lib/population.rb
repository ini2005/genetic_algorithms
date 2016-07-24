class Population

  attr_reader :individuals



  def initialize(population_size, fitness_calc, generate = false)

    @size = 0
    @individuals = []
    @sorted_individuals = nil

    if generate
      (0..population_size - 1).each do |i|

        @individuals.push Individual.new(fitness_calc)

      end
    end

  end

  def individual_at(index)
    @individuals[index]
  end

  def save_individual(index, individual)
    @individuals[index] = individual
  end

  def size
    @individuals.count
  end

  def nth_fittest(n = 1)
    calc_fittest
    @sorted_individuals[n - 1]
  end

  private

  def calc_fittest

    @sorted_individuals = @individuals.dup
    @sorted_individuals.sort_by! { |individual| individual.fitness}
  end

end
