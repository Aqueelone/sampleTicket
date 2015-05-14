require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  setup do
    @category = categories(:one)
    @category2 = categories(:two)
    @category3 = categories(:three)
    @categories = [@category, @category2, @category3]
    @user = users(:three)
    @moderator = users(:two)
    @admin = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create categories" do
    assert_not_nil session[:user_id] 
    @categories.each do |test_category| 
      assert_difference 'Category.count' do 
        post :create, params: { category: {name: test_category.name + " - test"} }      
        assert_redirected_to :controller => :categories, :action => :show, :id => test_category.id  
      end
    end
  end

  test "should show categories" do
    get :show, id: @category.to_param
    assert_response :success
    get :show, id: @category2.to_param
    assert_response :success
    get :show, id: @category3.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @category.to_param
    assert_response :success
    get :edit, id: @category2.to_param
    assert_response :success
    get :edit, id: @category3.to_param
    assert_response :success
  end

  test "should update category" do
    put :update, id: @category.to_param, category: @category.attributes
    assert_redirected_to category_path(assigns(:category))
    put :update, id: @category2.to_param, category: @category2.attributes
    assert_redirected_to category_path(assigns(:category))
    put :update, id: @category2.to_param, category: @category3.attributes
    assert_redirected_to category_path(assigns(:category))
  end

  test "should destroy category" do
    assert_difference('Category.count', -1) do
      delete :destroy, id: @category.to_param
      delete :destroy, id: @category2.to_param
      delete :destroy, id: @category3.to_param
    end

    assert_redirected_to categories_path
  end
end
