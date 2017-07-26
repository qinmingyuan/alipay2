# Alipay
A unofficial alipay ruby gem.

Alipay official document: https://doc.open.alipay.com/.

本项目基于 [Rei](https://github.com/chloerei) 的[版本](https://github.com/chloerei/alipay)，主要是支持新版api.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'alipay2', '~> 1.0.beta'
```

And then execute:

```console
$ bundle
```

## Configuration

```ruby
Alipay.pid = 'YOUR_PID'
Alipay.key = 'YOUR_KEY'

#Alipay.sign_type = 'MD5' # Available values: MD5, RSA. Default is MD5
#Alipay.debug_mode = true # Enable parameter check. Default is true.
```

You can set default key, or pass a key directly to service method:

```ruby
Service.create_partner_trade_by_buyer_url({
  out_trade_no: 'OUT_TRADE_NO',
  # Order params...
}, {
  pid: 'ANOTHER_PID',
  key: 'ANOTHER_KEY',
})
```

## menu

1. 电脑网站支付（即时到账）

文档[链接](https://doc.open.alipay.com/doc2/detail.htm?treeId=62&articleId=103566&docType=1)
* [即时到账交易接口](#即时到账交易接口)
* [即时到账有密退款接口](#即时到账有密退款接口)

2. 手机网站支付
* [手机网站支付接口](#手机网站支付接口)

3. 通用
* [交易查询接口]
* [交易关闭接口]
* [交易退款接口]
* [交易退款查询接口]
* [查询账单下载地址接口]


## Service

### 即时到账交易接口
* 接口名称：`create_direct_pay_by_user`
* 文档：[链接](https://doc.open.alipay.com/docs/doc.htm?treeId=62&articleId=104743&docType=1）

| Key | Requirement | Description |
| --- | --- | --- |
| out_order_no | required | Order id in your application. |
| subject | required | Order subject. |
| total_fee | required | Order’s total fee. |
| return_url | optional | Redirect customer to this url after payment. |
| notify_url | optional | Alipay asyn notify url. |

```ruby
# Usage
Alipay::Service.create_direct_pay_by_user_url(arguments, options = {})
# Example
Alipay::Service.create_direct_pay_by_user_url(
  out_trade_no: '20150401000-0001',
  subject: 'Order Name',
  total_fee: '10.00',
  return_url: 'https://example.com/orders/20150401000-0001',
  notify_url: 'https://example.com/orders/20150401000-0001/notify'
)
```

### 即时到账有密退款接口
https://doc.open.alipay.com/docs/doc.htm?treeId=62&articleId=104744&docType=1
接口名称：refund_fastpay_by_platform_pwd

#### Arguments
| Key | Requirement | Description |
| --- | --- | --- |
| batch_no | required | Refund batch no, you should store it to db to avoid alipay duplicate refund. |
| data | required | Refund data, a hash array. |
| notify_url | required | Alipay notify url. |

##### Data Item
| Key | Requirement | Description |
| --- | --- | --- |
| trade_no | required | Trade number in alipay system. |
| amount | required | Refund amount. |
| reason | required | Refund reason. Less than 256 bytes, could not contain special characters: ^ $ | #. |

#### Example

```ruby
# Usage example
batch_no = Alipay::Utils.generate_batch_no # refund batch no, you SHOULD store it to db to avoid alipay duplicate refund
Alipay::Service.refund_fastpay_by_platform_pwd_url(
  batch_no: batch_no,
  data: [{
    trade_no: '201504010000001',
    amount: '10.0',
    reason: 'REFUND_REASON'
  }],
  notify_url: 'https://example.com/orders/20150401000-0001/refund_notify'
)
# Return
# https://mapi.alipay.com/gateway.do?service=refund_fastpay_by_platform_pwd&...
```

### 验证通知

```ruby
# Rails
# params except :controller_name, :action_name, :host, etc.
notify_params = params.except(*request.path_parameters.keys)
Alipay::Wap::Notify.verify?(notify_params)
```

## Contributing
Bug report or pull request are welcome.

### Make a pull request

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Please write unit test with your code if necessary.

## Donate
Donate to maintainer let him make this gem better.

Alipay donate link: http://chloerei.com/donate/ .
