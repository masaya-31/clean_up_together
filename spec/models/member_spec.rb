require 'rails_helper'

RSpec.describe 'Memberモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { member.valid? }

    let!(:other_member) { create(:member) }
    let(:member) { build(:member) }

    context 'nameカラム' do
      it '空欄でないこと' do
        member.name = ''
        is_expected.to eq false
      end
      it '1文字以上であること: 1文字は〇' do
        member.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq true
      end
      it '15文字以内であること: 16文字は×' do
        member.name = Faker::Lorem.characters(number: 16)
        is_expected.to eq false
      end
      it '15文字以内であること: 15文字は〇' do
        member.name = Faker::Lorem.characters(number: 15)
        is_expected.to eq true
      end
    end
  end
end