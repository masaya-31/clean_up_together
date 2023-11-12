# frozen_string_literal: true

require 'rails_helper'

describe 'ユーザーログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
      it 'aboutページへのリンクが表示される' do
        expect(page).to have_link "", href: about_path
      end
      it 'Log inページへのリンクが表示される' do
        expect(page).to have_link "", href: new_member_session_path
      end
      it 'Sign inページへのリンクが表示される' do
        expect(page).to have_link "", href: new_member_registration_path
      end
    end
  end
  
  describe 'About画面のテスト' do
    before do
      visit about_path
    end
    
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/about'
      end
    end
  end
end