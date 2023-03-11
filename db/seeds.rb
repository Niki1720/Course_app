User.create!(email: 'admin@wp.pl', password: 'haslo123', password_confirmation: 'haslo123')

30.times do
  Course.create!([{
    title: Faker::Educator.course_name,
    description: Faker::TvShows::GameOfThrones.quote,
    user_id: User.first.id
  }])
end