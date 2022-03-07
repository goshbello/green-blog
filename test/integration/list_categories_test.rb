require "test_helper"

class ListCategoriesTest < ActionDispatch::IntegrationTest
  
  def setup
    @category = Category.create(name: "Sports")
    @category2 = Category.create(name: "Travel") 
  end

  test "should show category listing" do
    get '/categories'  # get the route to categories listing page

    # then we need to look for link, that matches the path to the category name. Then ones we confirm that, we return the category name in text rather than link
    assert_select "a[href=?]", category_path(@category), text: @category.name
    assert_select "a[href=?]", category_path(@category2), text: @category2.name
  end
end
