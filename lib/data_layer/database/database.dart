import 'package:la_vie/presentation_layer/shared/constants/constants.dart';
import 'package:sqflite/sqflite.dart';


Database? database;
void createDataBase()async
{
   database=await openDatabase(
    'Favorite.db',
    version: 1,
    onCreate: (database,version)
    async{
      await database
          .execute(
          'CREATE TABLE Favorite (id INTEGER PRIMARY KEY, photo TEXT, name INTEGER, price INTEGER,amount INTEGER)').then((value)
      {
        print('database created');
      }).catchError((error)
      {
        print('Error when created database${error.toString()}');
      });
    },
    onOpen: (database)
    {
      getDataFromDataBase(database).then((value)
      {
        favorites=value;
        print('mmmmmmmmmm');
        print(favorites);
      });
      print('database open');

    },
  );
}

Future<void> insertToDataBase(
    {
      String? photo,
      String? name,
      int? price,
      int? amount,

    })
async {
  await database!.transaction((txn)
  async{
    await txn.rawInsert('INSERT INTO Favorite(photo,name,price,amount) VALUES("$photo","$name","$price","$amount")')
        .then((value)
    {
      print('$value inserted successfully');
    }).catchError((error)
    {
      print('Error when inserting ${error.toString()}');

    });
    return null;
  });
}

Future<List<Map>> getDataFromDataBase(database)async
{
  return await database!.rawQuery('SELECT * FROM Favorite');
}