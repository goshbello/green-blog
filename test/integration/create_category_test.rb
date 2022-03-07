# Integration Test
#******************


# I learnt how to use integration test, test the process of creating a new category. First by getting the new form, completing the form and sending it. Checked if we are redirected to the right path or route. 

# In all integration test, test all the individual function test to ensure the work together without errors.  

# Functional test, test each controller function

require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest

  setup do
 
    # we have to hard code admin user, to be able to perform test to say only admin can create category
    @admin_user = User.create(username: "Ken Coco", email: "kenc@bootcamp.com", password: "password123", admin: true)
  
    sign_in_as(@admin_user) # here we signed in admin user automatically since its needed for all test 
  end


  test "get new category form and create category" do
    get "/categories/new" # getting the form route
    assert_response :success # check the above was successful
    assert_difference 'Category.count', 1 do  #check of the total category count increase by 1
      post categories_path, params: {category: {name: "News"} }
      assert_response :redirect # check if there is redirect
    end
    follow_redirect!
    assert_response :success # follow the redirect and confirm success
    assert_match "News", response.body  #confirm the name of the newly created category appears on or its showing on the redirected page
  end

  test "get new category form and reject invalid category submission" do
    get "/categories/new" # getting the form route
    assert_response :success # check the above was successful
    assert_no_difference 'Category.count' do # assert_no_difference in catagory count
      post categories_path, params: {category: {name: " "} } # assuming user tries to send blank form
    end
    # we can use any or all of the codes below to catch wrong submission
    assert_match "errors", response.body  #confirm the word "errors" is found in the html h4 tag in the errors message. This will mean, the submission was not sucessful,
    #assert_select 'div/flash-msg' # we can also check to see if there is a div with class of "alert" showing in the page
    assert_select 'h4.alert-heading' # we can also check of the h4 error message shows up
  end
end
