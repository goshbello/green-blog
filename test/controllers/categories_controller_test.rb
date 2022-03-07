
# Function Test / Functional Test
# ***************

# Funtional test or controller testing is used to test individual action within the controller to ensure they working as it should. Example we can test the "new action", "show action" or "index action" to ensure that we are able to access their routes. So for new action, we will check we are able to access the new form or the route, the show action, to get access the show template, and index action to ensure we can access the index route to see the listings



require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = Category.create(name: "Sports")

    # we have to hard code admin user, to be able to perform test to say only admin can create category
    @admin_user = User.create(username: "Ken Coco", email: "kenc@bootcamp.com", password: "password123", admin: true)
  end

  test "should get index" do
    get categories_url
    assert_response :success
  end

  test "should get new" do
    sign_in_as(@admin_user) # we wrote this method in the "test_helper.rb" file in test folder
    get new_category_url
    assert_response :success
  end

  test "should create category" do
    sign_in_as(@admin_user) # we wrote this method in the "test_helper.rb" file in test folder
    assert_difference('Category.count', 1) do
      post categories_url, params: { category: { name: "Travel"  } }
    end

    assert_redirected_to category_url(Category.last)
  end

  # restrict creating category to ONLY admin user
  test "should not create category if not admin" do
    assert_no_difference('Category.count') do  # we assert no difference since the category count will not be updated
      post categories_url, params: { category: { name: "Travel"  } }
    end

    assert_redirected_to categories_url
  end

  test "should show category" do
    get category_url(@category)
    assert_response :success
  end

  # test "should get edit" do
  #   get edit_category_url(@category)
  #   assert_response :success
  # end

  # test "should update category" do
  #   patch category_url(@category), params: { category: {  } }
  #   assert_redirected_to category_url(@category)
  # end

  # test "should destroy category" do
  #   assert_difference('Category.count', -1) do
  #     delete category_url(@category)
  #   end

  #   assert_redirected_to categories_url
  # end
end
