# encoding: utf-8

require './grammars/simple'
require './grammars/advanced'
require './grammars/variable'


define_type :robocode do
  extends(:setup, :simple)

  population  20
  elites      0

  evaluations = 500

  representation :grammar_derivation, length:400, max_wraps: 0, root: 'main', rules: advanced_grammar

  selector :s, :tournament, size:5
  variator :x, :one_point_crossover, rate: 0.4, source: :s
  variator :m, :uniform_mutation, rate: 0.2, source: :x

  # REMEMBER TO SET YOUR PATH USING THE PATH VARIABLE BELOW:
  # - Use an absolute path.
  evaluator :robocode, [threads: 4, path: '/home/james/robocode'] do

    # If the integer sequence failed to produce a viable grammar derivation
    # then assign this individual the worst possible fitness.
    return Fitness::Worst.new if tank.nil?

    # Battle against all tanks from a set
    tank_set = ['sample.Fire', 'sample.TrackFire', 'sample.Tracker','sample.RamFire', 'sample.Walls']

    results = 0

    for opponent_tank in tank_set do
      results += ((battle([tank.full_name, opponent_tank], rounds: 5, verbose: false))[tank.full_name][:score_share])
    end

    fitness = results / tank_set.length

    return Fitness::Simple.new(true, fitness)

  end

  # The number of evaluations after which your algorithm should terminate.
  termination_condition :evaluations, :evaluations, limit: evaluations

  logger :best_individual,    output_directory: "output"
  logger :full_fitness_dump,  output_directory: "output"

end

# Try changing the mode to :jruby to add multi-threading.
run(:robocode, mode: :jruby)
