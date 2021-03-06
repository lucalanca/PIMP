require 'test_helper'

class PunchesControllerTest < ActionController::TestCase
  setup do
    @punch = punches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:punches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create punch" do
    assert_difference('Punch.count') do
      post :create, punch: { lat: @punch.lat, lng: @punch.lng, local_ip: @punch.local_ip, mac: @punch.mac, public_ip: @punch.public_ip }
    end

    assert_redirected_to punch_path(assigns(:punch))
  end

  test "should show punch" do
    get :show, id: @punch
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @punch
    assert_response :success
  end

  test "should update punch" do
    put :update, id: @punch, punch: { lat: @punch.lat, lng: @punch.lng, local_ip: @punch.local_ip, mac: @punch.mac, public_ip: @punch.public_ip }
    assert_redirected_to punch_path(assigns(:punch))
  end

  test "should destroy punch" do
    assert_difference('Punch.count', -1) do
      delete :destroy, id: @punch
    end

    assert_redirected_to punches_path
  end
end
