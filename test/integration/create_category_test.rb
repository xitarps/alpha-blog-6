require 'test_helper'

class CreateCategoryTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = User.create(username: 'Administrator',
                        email: 'adm@aphablog.com',
                        password:'hiimadmin123',
                        admin: true)
  end
  test "get the new category form and create the category" do
    sing_in_as(@admin_user,"hiimadmin123")
    get "/categories/new"

    assert_response :success

    assert_difference 'Category.count',1 do
      post categories_path, params: {category: {name: 'Cooking'}}

      assert_response :redirect

    end

    follow_redirect!

    assert_response :success

    assert_match 'Cooking', response.body
  end

  test "get the new category form and reject invalid category submission" do
    sing_in_as(@admin_user,"hiimadmin123")
    get "/categories/new"

    assert_response :success

    assert_no_difference 'Category.count' do
      post categories_path, params: {category: {name: ' '}}
    end
    
    assert_match 'errors', response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end
end
