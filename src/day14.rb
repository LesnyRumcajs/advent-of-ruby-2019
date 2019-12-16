class Ingredient
  attr_reader :quantity, :name
  def initialize(description)
    quantity, @name = description.split
    @quantity = quantity.to_i
  end
end

class Reaction
  attr_reader :result, :ingredients
  def initialize(recipe)
    *@ingredients, @result = recipe.scan(/\d+ \w+/)
                                   .map{|chunk| Ingredient.new(chunk)}
  end
end

class NanoFactory
  def initialize(data)
    @reactions = Hash.new
    data.lines.each do |recipe|
      reaction = Reaction.new(recipe)
      @reactions[reaction.result.name] = [reaction.result.quantity, reaction.ingredients]
    end
  end

  def process(name, quantity, required = {}, waste = {})
    waste[name] ||= 0
    required[name] ||= 0

    produced, ingredients = @reactions[name]

    if produced < waste[name]
      waste[name] -= quantity
    else
      reactions = [0, ((quantity - waste[name]) / produced.to_f).ceil].max
      required[name] -= waste[name]
      waste[name] = reactions * produced - required[name] unless name == 'FUEL'

      ingredients.each do |ingredient|
        required[ingredient.name] ||= 0
        required[ingredient.name] += reactions * ingredient.quantity
        process(ingredient.name, ingredient.quantity * reactions, required, waste) unless ingredient.name == 'ORE'
      end
    end

    required[name] = 0
    required['ORE']
  end

  def max_ingredient(name, ore_amount)
    # use Array#bsearch find-minimum mode
    (1..ore_amount).bsearch do |ingredient_amount|
      process(name, ingredient_amount) > ore_amount
    end - 1
  end
end

factory = NanoFactory.new(File.read('res/day14.txt'))

# part 1
p factory.process('FUEL', 1)

# part 2
p factory.max_ingredient('FUEL', 1e12.to_i)
