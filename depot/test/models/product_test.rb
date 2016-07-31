#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products 

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end  

  test "product price must be positive" do
    product = Product.new(title:  "My title",
                          description: "awesome book",
                          image_url: 'zzz.jpg')
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 2
    assert product.valid?
  end

  def new_product(image_url)
    Product.new(title:  "My title",
                description: "awesome book",
                price: 1,
                image_url: image_url)
  end

  test "image url format" do
    ok = %w{ fred.gif freddie.jpg fre.png fred/image.gif}
    bad = %w{ stuff.stuff notgood.html another_bad_url.xml}

    ok.each do |name|
      assert new_product(name).valid?, "#{name} should be valid"
    end

    bad.each do |name|
      assert new_product(name).invalid?, "#{name} should not be valid"
    end
  end

  test "product title must be unique" do
    product = Product.new(title:  products(:ruby).title,
                          description: "awesome book",
                          price: 1,
                          image_url: 'zzz.jpg')

    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')], product.errors[:title]
  end
end
