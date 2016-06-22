# pan

Cares about PANs ([Primary Account Number](https://en.wikipedia.org/wiki/Payment_card_number)).

## Examples

```ruby
require 'pan'

pan = '1234567890123456'

Pan.mask(pan)
#=> '123456******3456'

pan
#=> '1234567890123456'

Pan.truncate(pan)
#=> '123456******3456'

pan
#=> '123456******3456'
```

(Yes, that's the difference between masking and truncating a PAN in PCI DSS
terminology.)

You may decide how much to mask (or truncated) and the character(s) that the
digits are replaced with:

```ruby
Pan.template = [0, 'x', 4]

Pan.mask('1234567890123456')
#=> 'xxxxxxxxxxxx3456'
```

```ruby
pan = '1234567890123456'

Pan.mask(pan, template: [4, 'X', 4])
#=> '1234XXXXXXXX3456'

Pan.truncate(pan, template: [6, '*', 4]); pan
#=> '123456******3456'
```
