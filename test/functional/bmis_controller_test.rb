require 'test_helper'

class BmisControllerTest < ActionController::TestCase
  setup do
    @bmi = bmis(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bmis)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bmi" do
    assert_difference('Bmi.count') do
      post :create, bmi: @bmi.attributes
    end

    assert_redirected_to bmi_path(assigns(:bmi))
  end

  test "should show bmi" do
    get :show, id: @bmi.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bmi.to_param
    assert_response :success
  end

  test "should update bmi" do
    put :update, id: @bmi.to_param, bmi: @bmi.attributes
    assert_redirected_to bmi_path(assigns(:bmi))
  end

  test "should destroy bmi" do
    assert_difference('Bmi.count', -1) do
      delete :destroy, id: @bmi.to_param
    end

    assert_redirected_to bmis_path
  end
end
