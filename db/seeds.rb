users = [
  {email: 'test@example.com', password: '123', name: 'Melvin Lau'}
]

users.each { |user| User.create(user) }
