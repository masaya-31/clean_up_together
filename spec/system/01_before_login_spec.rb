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

  describe 'ヘッダーのテスト: ログインしていない場合' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'ロゴ(Keep Clean House)がトップ画面へのリンクである' do
        expect(page).to have_link '', href: root_path
      end
    end
  end

  describe 'ユーザーの新規登録テスト' do
    before do
      visit new_member_registration_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/members/sign_up'
      end
      it '「新規登録」と表示される' do
        expect(page).to have_content '新規登録'
      end
      it 'nameフォームが表示される' do
        expect(page).to have_field 'member[name]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'member[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'member[password]'
      end
      it 'password_confirmationフォームが表示される' do
        expect(page).to have_field 'member[password_confirmation]'
      end
      it '登録するボタンが表示される' do
        expect(page).to have_button '登録する'
      end
    end
  end
end