# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do
  describe "バリデーションのテスト" do
    subject { post.valid? }

    let(:member) { create(:member) }
    let!(:post) { build(:post, member_id: member.id) }

    context 'titleカラム' do
      it '空欄でないこと' do
        post.title = ''
        is_expected.to eq false
      end
      it '30文字以内であること：31文字は×' do
        post.title = Faker::Lorem.characters(number: 31)
        is_expected.to eq false
      end
      it '30文字以内であること：30文字は〇' do
        post.title = Faker::Lorem.characters(number: 5)
        is_expected.to eq true
      end
    end

    context 'toolカラム' do
      it '空欄でないこと' do
        post.tool = ''
        is_expected.to eq false
      end
    end

    context 'bodyカラム' do
      it '空欄でないこと' do
        post.body = ''
        is_expected.to eq false
      end
    end
  end
end