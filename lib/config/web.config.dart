var baseUrl = 'http://192.168.31.26:8888';
var webApi = {
  'categoryList': baseUrl + '/base/coffeetype',
  'cusUpload': baseUrl + '/cus/upload',
  'cusLogin': baseUrl + '/base/cuslogin',
  'coffeeList': baseUrl + '/base/coffeebycode',
  'coffeeType': baseUrl + '/base/getcoffeetype',
  'coffeeDetail': baseUrl + '/base/getcoffeebyid',
  'cart': baseUrl + '/cus/cart',
  'addCart': baseUrl + '/cus/addcart',
  'reduceCart': baseUrl + '/cus/reduceCart',
  'delCart': baseUrl + '/cus/delcart',
  'checkStatus': baseUrl + '/cus/checkStatus',
  'addressList': baseUrl + '/cus/getAddress',
  'addAddress': baseUrl + '/cus/addAddress',
  'orderList': baseUrl + '/cus/getOrder',
  'orderDetail': baseUrl + '/cus/orderDetail'
};