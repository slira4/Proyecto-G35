# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

# rubocop:disable Metrics/BlockLength
describe 'Create reservation form testing', type: :feature do
  before :each do
    movie1 = Movie.create(title: 'Matrix', age: 18, sucursal: 'Santiago', languaje: 'Inglés')
    MovieTime.create(movie_id: movie1.id, time: 'TANDA', date_start: Date.new(2022, 11, 11),
                     date_end: Date.new(2022, 11, 13), room: 1)
    movie2 = Movie.create(title: 'Interstellar', age: 18, sucursal: 'Santiago', languaje: 'Español')
    MovieTime.create(movie_id: movie2.id, time: 'TANDA', date_start: Date.new(2022, 11, 11),
                     date_end: Date.new(2022, 11, 13), room: 2)
    movie3 = Movie.create(title: 'Hercules', age: 7, sucursal: 'Santiago', languaje: 'Inglés')
    MovieTime.create(movie_id: movie3.id, time: 'TANDA', date_start: Date.new(2022, 11, 11),
                     date_end: Date.new(2022, 11, 13), room: 3)
    movie4 = Movie.create(title: 'Marmaduke', age: 9, sucursal: 'Santiago', languaje: 'Español')
    MovieTime.create(movie_id: movie4.id, time: 'TANDA', date_start: Date.new(2022, 11, 11),
                     date_end: Date.new(2022, 11, 13), room: 4)
    movie5 = Movie.create(title: 'Duro de matar', age: 18, sucursal: 'Regional', languaje: 'Inglés')
    MovieTime.create(movie_id: movie5.id, time: 'TANDA', date_start: Date.new(2022, 11, 11),
                     date_end: Date.new(2022, 11, 13), room: 5)
    movie6 = Movie.create(title: 'Depredador', age: 21, sucursal: 'Regional', languaje: 'Español')
    MovieTime.create(movie_id: movie6.id, time: 'TANDA', date_start: Date.new(2022, 11, 11),
                     date_end: Date.new(2022, 11, 13), room: 6)
    movie7 = Movie.create(title: 'Amigos Intocables', age: 14, sucursal: 'Regional',
                          languaje: 'Inglés')
    MovieTime.create(movie_id: movie7.id, time: 'TANDA', date_start: Date.new(2022, 11, 11),
                     date_end: Date.new(2022, 11, 13), room: 7)
    movie8 = Movie.create(title: 'A todo Gas', age: 12, sucursal: 'Regional', languaje: 'Español')
    MovieTime.create(movie_id: movie8.id, time: 'TANDA', date_start: Date.new(2022, 11, 11),
                     date_end: Date.new(2022, 11, 13), room: 8)
  end

  scenario 'User is 18, lives in Santiago and speaks english' do
    visit '/'
    fill_in 'date', with: '2022-11-11'
    fill_in 'age', with: 21
    select('Santiago', from: 'sucursal')
    select('Inglés', from: 'languaje')
    click_button('commit')
    # save_and_open_page
    expect(page).not_to(have_content('Duro de matar')) and expect(page).to(have_content('Matrix'))
    page.body.index('Matrix') < page.body.index('Interstellar')
  end

  scenario 'User is 18, lives in Santiago and speaks spanish' do
    visit '/'
    fill_in 'date', with: '2022-11-11'
    fill_in 'age', with: 21
    select('Santiago', from: 'sucursal')
    select('Español', from: 'languaje')
    click_button('commit')
    # save_and_open_page
    expect(page).not_to(have_content('Depredador')) and
      expect(page).to(have_content('Interstellar'))
    page.body.index('Matrix') > page.body.index('Interstellar')
  end

  scenario 'User is 18, lives in region and speaks english' do
    visit '/'
    fill_in 'date', with: '2022-11-11'
    fill_in 'age', with: 21
    select('Regional', from: 'sucursal')
    select('Inglés', from: 'languaje')
    click_button('commit')
    # save_and_open_page
    expect(page).not_to(have_content('Matrix')) and expect(page).to(have_content('Duro de matar'))
    page.body.index('Duro de matar') < page.body.index('Depredador')
  end

  scenario 'User is 18, lives in region and speaks spanish' do
    visit '/'
    fill_in 'date', with: '2022-11-11'
    fill_in 'age', with: 21
    select('Regional', from: 'sucursal')
    select('Español', from: 'languaje')
    click_button('commit')
    # save_and_open_page
    expect(page).not_to(have_content('Interstellar')) and
      expect(page).to(have_content('Depredador'))
    page.body.index('Duro de matar') > page.body.index('Depredador')
  end

  scenario 'User is not 18, lives in Santiago and speaks english' do
    visit '/'
    fill_in 'date', with: '2022-11-11'
    fill_in 'age', with: 17
    select('Santiago', from: 'sucursal')
    select('Inglés', from: 'languaje')
    click_button('commit')
    # save_and_open_page
    expect(page).not_to(have_content('Amigos Intocables')) and
      expect(page).to(have_content('Hercules')) and
      expect(page).not_to(have_content('Matrix'))
    page.body.index('Hercules') < page.body.index('Marmaduke')
  end

  scenario 'User is not 18, lives in Santiago and speaks spanish' do
    visit '/'
    fill_in 'date', with: '2022-11-11'
    fill_in 'age', with: 17
    select('Santiago', from: 'sucursal')
    select('Español', from: 'languaje')
    click_button('commit')
    # save_and_open_page
    expect(page).not_to(have_content('A todo Gas')) and
      expect(page).to(have_content('Marmaduke')) and
      expect(page).not_to(have_content('Matrix'))
    page.body.index('Hercules') > page.body.index('Marmaduke')
  end

  scenario 'User is not 18, lives in region and speaks english' do
    visit '/'
    fill_in 'date', with: '2022-11-11'
    fill_in 'age', with: 17
    select('Regional', from: 'sucursal')
    select('Inglés', from: 'languaje')
    click_button('commit')
    # save_and_open_page
    expect(page).not_to(have_content('Hercules')) and
      expect(page).to(have_content('Amigos Intocables')) and
      expect(page).not_to(have_content('Duro de matar'))
    page.body.index('Amigos Intocables') < page.body.index('A todo Gas')
  end

  scenario 'User is not 18, lives in region and speaks spanish' do
    visit '/'
    fill_in 'date', with: '2022-11-11'
    fill_in 'age', with: 17
    select('Regional', from: 'sucursal')
    select('Español', from: 'languaje')
    click_button('commit')
    # save_and_open_page
    expect(page).not_to(have_content('Marmaduke')) and
      expect(page).to(have_content('A todo Gas')) and
      expect(page).not_to(have_content('Duro de matar'))
    page.body.index('Amigos Intocables') > page.body.index('A todo Gas')
  end
end
# rubocop:enable Metrics/BlockLength
