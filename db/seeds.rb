# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Cat.destroy_all

ApplicationRecord.connection.reset_pk_sequence!('cats')

Cats = Cat.create([
    { name: 'Cronut', birth_date: '2018-08-30', color: 'black', sex: 'F' },
    { name: 'Crucifix', birth_date: '2015-06-08', color: 'white', sex: 'M' },
    { name: '8-Bit', birth_date: '2019-11-30', color: 'black', sex: 'F' },
    { name: 'Heirloom', birth_date: '2017-09-08', color: 'black', sex: 'F' },
    { name: 'Marfa', birth_date: '2019-10-04', color: 'brown', sex: 'F' },
    { name: 'Venmo', birth_date: '2019-10-08', color: 'orange', sex: 'F' },
    { name: 'Tattoed', birth_date: '2012-02-20', color: 'brown', sex: 'F' },
    { name: 'Viral', birth_date: '2010-05-01', color: 'orange', sex: 'M' },
    { name: 'Normcore', birth_date: '2013-10-10', color: 'brown', sex: 'F' },
    { name: 'Stumptown', birth_date: '2015-09-09', color: 'orange', sex: 'F' },
    { name: 'Farm-To-Table', birth_date: '2018-06-03', color: 'orange', sex: 'M' }
])
