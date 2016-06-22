require_relative '../lib/pan.rb'

describe 'Pan#mask' do
  it 'default template' do
    expect(Pan.mask('')).to                     eq ''
    expect(Pan.mask('1')).to                    eq '1'
    expect(Pan.mask('12')).to                   eq '12'
    expect(Pan.mask('123')).to                  eq '123'
    expect(Pan.mask('1234')).to                 eq '1234'
    expect(Pan.mask('12345')).to                eq '12345'
    expect(Pan.mask('123456')).to               eq '123456'
    expect(Pan.mask('1234567')).to              eq '1234567'
    expect(Pan.mask('12345678')).to             eq '12345678'
    expect(Pan.mask('123456789')).to            eq '123456789'
    expect(Pan.mask('1234567890')).to           eq '1234567890'
    expect(Pan.mask('12345678901')).to          eq '123456*8901'
    expect(Pan.mask('123456789012')).to         eq '123456**9012'
    expect(Pan.mask('1234567890123')).to        eq '123456***0123'
    expect(Pan.mask('12345678901234')).to       eq '123456****1234'
    expect(Pan.mask('123456789012345')).to      eq '123456*****2345'
    expect(Pan.mask('1234567890123456')).to     eq '123456******3456'
    expect(Pan.mask('12345678901234567')).to    eq '123456*******4567'
    expect(Pan.mask('123456789012345678')).to   eq '123456********5678'
    expect(Pan.mask('1234567890123456789')).to  eq '123456*********6789'
    expect(Pan.mask('12345678901234567890')).to eq '123456**********7890'
  end

  it 'per mask template' do
    expect(Pan.mask('1234', template: [1,'-',1])).to eq '1--4'
  end

  it 'long replacement string' do
    expect(Pan.mask('1234', template: [1,'abc',1])).to eq '1abcabc4'
  end

  context 'front/end corner cases' do
    let (:pan) { '12345' }

    it 'some in front, some in end' do
      expect(Pan.mask(pan, template: [2,'-',2])).to eq '12-45'
    end

    it 'none in front, some in end' do
      expect(Pan.mask(pan, template: [0,'-',2])).to eq '---45'
    end

    it 'some in front, none in end' do
      expect(Pan.mask(pan, template: [2,'-',0])).to eq '12---'
    end

    it 'none in front, none in end' do
      expect(Pan.mask(pan, template: [0,'-',0])).to eq '-----'
    end
  end

  context 'pan corner cases' do
    it 'empty pan' do
      expect(Pan.mask('', template: [1,'x',1])).to eq ''
      expect(Pan.mask('', template: [0,'x',0])).to eq ''
    end

    it 'nil pan fail' do
      expect{Pan.mask(nil)}.to raise_error(Pan::Error, /invalid pan/)
    end

    it 'integer pan fail' do
      expect{Pan.mask(1234567890123456)}.to raise_error(Pan::Error, /invalid pan/)
    end
  end

  it 'fails on invalid template' do
    expect{Pan.mask('', template: [-1,'x',0])}.to raise_error(Pan::Error, /invalid template/)
  end

  it 'custom global template' do
    previous_template, Pan.template = Pan.template, [2,'X',2]

    expect(Pan.mask('1234567890123456')).to eq '12XXXXXXXXXXXX56'

    Pan.template = previous_template
  end

  it 'does not changes the object' do
    pan = '1234567890123456'
    expect(Pan.mask(pan)).to eq '123456******3456'
    expect(pan).to eq pan
  end
end

describe 'Pan#truncate' do
  it 'uses #mask and changes the object' do
    pan = '1234'
    expect(Pan).to receive(:mask).with(pan, template: Pan::DEFAULT_TEMPLATE).and_return('1**4')
    Pan.truncate(pan)
    expect(pan).to eq '1**4'
  end
end
