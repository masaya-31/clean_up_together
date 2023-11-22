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

    context '新規登録成功のテスト' do
      before do
        fill_in 'member[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'member[email]', with: Faker::Internet.email
        fill_in 'member[password]', with: 'password'
        fill_in 'member[password_confirmation]', with: 'password'
      end

      it '正しく新規登録される' do
        expect { click_button '登録する' }.to change(Member.all, :count).by(1)
      end
      it '新規登録後のリダイレクト先が、新規登録できたユーザのマイページ画面になっている' do
        click_button '登録する'
        expect(current_path).to eq '/members/' + Member.last.id.to_s
      end
    end
  end

  describe 'ユーザログイン' do
    let(:member) { create(:member) }

    before do
      visit new_member_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/members/sign_in'
      end
      it '「ログイン」と表示される' do
        expect(page).to have_content 'ログイン'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'member[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'member[password]'
      end
      it 'ログインボタンが表示される' do
        expect(page).to have_button 'ログイン'
      end
      it 'nameフォームは表示されない' do
        expect(page).not_to have_field 'member[name]'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'member[email]', with: member.email
        fill_in 'member[password]', with: member.password
        click_button 'ログイン'
      end

      it 'ログイン後のリダイレクト先が、ログインしたユーザのマイページ画面になっている' do
        expect(current_path).to eq '/members/' + member.id.to_s
      end
    end
    
    context 'ログイン失敗のテスト' do
      before do
        fill_in 'member[email]', with: ''
        fill_in 'member[password]', with: ''
        click_button 'ログイン'
      end
      
      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/members/sign_in'
      end
    end
  end
end