require_relative 'config'
require_relative 'population'
require_relative 'individual'

class GA

  def self.run(fitness_calc)

    fittest = nil
    population = Population.new Config::POPULATION_SIZE, fitness_calc, true
    (1..Config::MAX_GENERATIONS).each do |generation|

      puts "Generation #{generation}"
      cur_fittest = population.nth_fittest

      if !fittest || cur_fittest.is_better_than(fittest)

        fittest = cur_fittest

        if fittest.fitness == fitness_calc.max_fitness
          puts "Finished after #{generation} generations"
          return fittest
        end
      end

      population = evolve_population population, fitness_calc

    end

    puts "Finished after #{Config::MAX_GENERATIONS} generations"
    fittest
  end


  def self.evolve_population(population, fitness_calc)

    new_population = Population.new population.size, fitness_calc
    # Keep our best individual
    if Config::ELITISM
      new_population.save_individual 0, population.nth_fittest
      elitism_offset = 1
    else
      elitism_offset = 0
    end

    # Loop over the population size and create new individuals with
    # crossover
    (elitism_offset..population.size - 1).each do |i|
      indiv1 = tournament_selection population, fitness_calc
      indiv2 = tournament_selection population, fitness_calc
      new_indiv = crossover indiv1, indiv2, fitness_calc
      mutate(new_indiv)
      new_population.save_individual i, new_indiv
    end

    new_population

  end


  # Crossover individuals
  def self.crossover(indiv1, indiv2, fitness_calc)
    child = Individual.new fitness_calc
    # Loop through genes
    (0..child.size - 1).each do |i|

      # Crossover
      if Random.rand <= Config::UNIFORM_RATE
        child.set_gene i, indiv1.genes[i]
      else
        child.set_gene i, indiv2.genes[i]
      end
    end
    child
  end

  # Mutate an individual
  def self.mutate(indiv)

    # Loop through genes
    (0..indiv.size - 1).each do |i|

      if Random.rand <= Config::MUTATION_RATE
        # Create random gene
        gene = Random.rand.round
        indiv.set_gene i, gene
      end
    end

  end

  # Select individuals for crossover
  def self.tournament_selection(pop, fitness_calc)
    # Create a tournament population
    tournament = Population.new Config::TOURNAMENT_SIZE, fitness_calc

    # For each place in the tournament get a random individual
    (0..Config::TOURNAMENT_SIZE - 1).each do |i|
      randomId = (Random.rand * pop.size)
      tournament.save_individual i, pop.individual_at(randomId)
    end
    # Get the fittest
    fittest = tournament.nth_fittest
    fittest
  end

end
