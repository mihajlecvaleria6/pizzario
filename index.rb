# frozen_string_literal: true

# promocode in menu
# done
def show_menu(promocode:, name: 'гість')
  puts "Привіт, #{name}"
  o_promocode = promocode
  puts o_promocode.class
  if %w[LIT10 MAMA20 MAMA50 BUG0].include?(o_promocode)
    puts "Промокод: #{o_promocode}"
  else
    puts 'Ти немаєш промокоду:('
  end
  puts 'Вітаємо в піцерії'
  puts 'Трошки гірше, ніж у мами!'
  puts 'Оберіть дію та введіть її номер:'
  puts "1. Назвіть нам своє ім'я"
  puts '2. Введіть промокод'
  puts '3. Меню піц'
  puts '4. Зробити замовлення'
  puts '5. Вийти'
end

# done
def ask_name(name:, promocode:)
  puts 'Як вас звати? (back - у головне меню)'
  name = gets.chomp
  #   if name == 'back'
  #     back(v: name, name: 'гість', promocode:)
  #   else
  puts "Ваше ім'я зареєстроване #{name}"
  run(name:, promocode:)
  #   end
end

# done
def handle_input(input:, name:, promocode:)
  return ask_name(name:, promocode:) if input == '1'
  return ask_promocode(name:, promocode:) if input == '2'
  return ask_menu(name:, promocode:) if input == '3'
  return ask_order(name:, pizza:, promocode:) if input == '4'

  exit if input == '5'

  run(name:, promocode:)
end

require 'yaml'

def list_of_promocods
  file_path = 'promocodes.yml'
  if File.exist?(file_path)
    return show_list = YAML.safe_load(File.read('promocodes.yml'), permitted_classes: [Symbol, String, Hash]) || []
  end

  show_list.push(
    {
      name_promocode: 'LIT10',
      absolute_discount: 0,
      percentage_discount: 10
    },
    {
      name_promocode: 'MAMA20',
      absolute_discount: 0,
      percentage_discount: 20
    },
    {
      name_promocode: 'MAMA500',
      absolute_discount: 50,
      percentage_discount: 0
    },
    {
      name_promocode: 'BUG0',
      absolute_discount: 0,
      percentage_discount: 0
    }
  )
  File.open('promocodes.yml', 'w') do |file|
    file.write(show_list.to_yaml)
  end
  show_list
end

def ask_promocode(name:, promocode:)
  puts 'Введіть промокод (back - у головне меню): '
  promocode = gets.chomp
  #   back(v: promocode, name:, promocode:)
  promocodes_list = list_of_promocods
  check_promocodes = promocodes_list.detect do |promo|
    promocode.upcase == promo[:name_promocode]
  end

  return unless check_promocodes

  puts "Promocode: #{check_promocodes[:name_promocode]}"
  puts "Discount -#{check_promocodes[:absolute_discount]}UAH" if check_promocodes[:absolute_discount] != 0
  puts "Discount -#{check_promocodes[:percentage_discount]}%" if check_promocodes[:percentage_discount] != 0
end

# def ask_menu(name:, promocode:)
#   pizza_menu = {
#     margarita: 'margarita',
#     bbq: 'bbq',
#     four_cheese: 'four_cheese',
#     pepperoni: 'pepperoni'
#   }
#   puts 'МЕНЮ ПІЦ'
#   puts 'margarita | Маргарита «Мама схвалила'
#   puts '180 грн | 8 шматочків | 500 г'
#   puts 'Томати, моцарела та базилік.'
#   puts ''
#   puts 'bbq | BBQ «Дим із дедлайну»'
#   puts '260 грн | 8 шматочків | 650 г'
#   puts 'Курка, бекон, цибуля та соус BBQ.'
#   puts ''
#   puts 'Four_cheese | «Чотири сири й один конфлікт»'
#   puts '280 грн | 6 шматочків | 550 г'
#   puts 'Чотири сири. Хто головний - досі не вирішили.'
#   puts ''
#   puts 'pepperoni | Пепероні «Гострий коміт»'
#   puts '240 грн | 8 шматочків | 600 г'
#   puts 'Пепероні, моцарела та томати.'

#   run(name:, promocode:)
# end

# def ask_order(name:, promocode:, pizza:)
#   if pizza != 'next'
#     puts 'back - у меню; чернетку замовлення буде скасовано.'
#     puts 'Введіть слаг піци:'
#     pizza = gets.chomp
#     back(v: pizza, name:, promocode:)
#     puts "Скільки піц #{pizza}"
#     count = gets.chomp
#     if pizza == 'margarita'
#       orders = 180.0
#     elsif pizza == 'bbq'
#       orders = 260.0
#     elsif pizza == 'Four_cheese'
#       orders = 280.0
#     elsif pizza == 'pepperoni'
#       orders = 240.0
#     end
#     orders.to_i
#     price = orders * count.to_i
#     overall_price = price
#     puts "Додано: #{orders} * #{count} = #{price} грн."
#     puts 'back - у меню; чернетку замовлення буде скасовано.'
#     puts 'Введіть ще один слаг або next, якщо це все:'
#     pizza = gets.chomp
#     back(v: pizza, name:, promocode:)

#   end

#   return run(name: name, promocode:) if orders == 'next'

#   puts 'back - у меню; чернетку замовлення буде скасовано.'
#   puts 'Скільки гостей їстимуть піцу?'
#   puts 'Вкажіть число від 0 до 8, включно із собою.'
#   puts '0 - замовлення на виніс.'
#   people = gets.chomp
#   back(v: people, name:, promocode:)
#   puts 'back - у меню; чернетку замовлення буде скасовано. Додати сирні бортики до кожної піци?'
#   puts 'Це +10% до вартості піц. (так / ні)'
#   cheese = gets.chomp
#   price_of_add_cheese = cheese
#   return price_of_add_cheese = 0.1 if cheese == 'так'

#   puts 'Готуємо ваш чек...'
# end

def back(v:, name:, promocode:)
  return unless v == 'back'

  run(name:, promocode:)
end

def run(name: nil, promocode: nil)
  show_menu(name:, promocode:)
  user_input = gets.chomp
  handle_input(input: user_input, name:, promocode:)
  run(name:, promocode:)
end

run
