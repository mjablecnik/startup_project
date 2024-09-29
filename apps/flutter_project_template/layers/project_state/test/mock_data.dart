import 'dart:convert';

import 'package:project_repository/clients/http_client.dart';
import 'package:project_data/entities/user.dart';

final exampleResponse = HttpResponse(jsonDecode('''{
}'''));

final userLoginResponse = HttpResponse(jsonDecode('''{
  "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJlbWlseXMiLCJlbWFpbCI6ImVtaWx5LmpvaG5zb25AeC5kdW1teWpzb24uY29tIiwiZmlyc3ROYW1lIjoiRW1pbHkiLCJsYXN0TmFtZSI6IkpvaG5zb24iLCJnZW5kZXIiOiJmZW1hbGUiLCJpbWFnZSI6Imh0dHBzOi8vZHVtbXlqc29uLmNvbS9pY29uL2VtaWx5cy8xMjgiLCJpYXQiOjE3MjczNTc3NzEsImV4cCI6MTcyNzM2MTM3MX0.-_tQ6x_6jp_8Q8g5yGaYSdB57M81jpKlo5O3zNpJTcs",
  "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJlbWlseXMiLCJlbWFpbCI6ImVtaWx5LmpvaG5zb25AeC5kdW1teWpzb24uY29tIiwiZmlyc3ROYW1lIjoiRW1pbHkiLCJsYXN0TmFtZSI6IkpvaG5zb24iLCJnZW5kZXIiOiJmZW1hbGUiLCJpbWFnZSI6Imh0dHBzOi8vZHVtbXlqc29uLmNvbS9pY29uL2VtaWx5cy8xMjgiLCJpYXQiOjE3MjczNTc3NzEsImV4cCI6MTcyOTk0OTc3MX0.Ws9IN9dXMHaVKI4us6BxN8bQgmZ3vrwwYEqr6PAojl0",
  "id": 1,
  "username": "emilys",
  "email": "emily.johnson@x.dummyjson.com",
  "firstName": "Emily",
  "lastName": "Johnson",
  "gender": "female",
  "image": "https://dummyjson.com/icon/emilys/128"
}'''));

final userDetailResponse = HttpResponse(jsonDecode('''
  {
     "id": 1,
     "firstName": "Emily",
     "lastName": "Johnson",
     "maidenName": "Smith",
     "age": 28,
     "gender": "female",
     "email": "emily.johnson@x.dummyjson.com",
     "phone": "+81 965-431-3024",
     "username": "emilys",
     "password": "emilyspass",
     "birthDate": "1996-5-30",
     "image": "https://dummyjson.com/icon/emilys/128",
     "bloodGroup": "O-",
     "height": 193.24,
     "weight": 63.16,
     "eyeColor": "Green",
     "hair": {
       "color": "Brown",
       "type": "Curly"
     },
     "ip": "42.48.100.32",
     "address": {
       "address": "626 Main Street",
       "city": "Phoenix",
       "state": "Mississippi",
       "stateCode": "MS",
       "postalCode": "29112",
       "coordinates": {
         "lat": -77.16213,
         "lng": -92.084824
       },
       "country": "United States"
     },
     "macAddress": "47:fa:41:18:ec:eb",
     "university": "University of Wisconsin--Madison",
     "bank": {
       "cardExpire": "03/26",
       "cardNumber": "9289760655481815",
       "cardType": "Elo",
       "currency": "CNY",
       "iban": "YPUXISOBI7TTHPK2BR3HAIXL"
     },
     "company": {
       "department": "Engineering",
       "name": "Dooley, Kozey and Cronin",
       "title": "Sales Manager",
       "address": {
         "address": "263 Tenth Street",
         "city": "San Francisco",
         "state": "Wisconsin",
         "stateCode": "WI",
         "postalCode": "37657",
         "coordinates": {
           "lat": 71.814525,
           "lng": -161.150263
         },
         "country": "United States"
       }
     },
     "ein": "977-175",
     "ssn": "900-590-289",
     "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.93 Safari/537.36",
     "crypto": {
       "coin": "Bitcoin",
       "wallet": "0xb9fc2fe63b2a6c003f1c324c3bfa53259162181a",
       "network": "Ethereum (ERC20)"
     },
     "role": "admin"
   }
'''));

final expectedLoginUser = User(
  userName: 'emilys',
  firstName: 'Emily',
  lastName: 'Johnson',
  token:
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJlbWlseXMiLCJlbWFpbCI6ImVtaWx5LmpvaG5zb25AeC5kdW1teWpzb24uY29tIiwiZmlyc3ROYW1lIjoiRW1pbHkiLCJsYXN0TmFtZSI6IkpvaG5zb24iLCJnZW5kZXIiOiJmZW1hbGUiLCJpbWFnZSI6Imh0dHBzOi8vZHVtbXlqc29uLmNvbS9pY29uL2VtaWx5cy8xMjgiLCJpYXQiOjE3MjczNTc3NzEsImV4cCI6MTcyNzM2MTM3MX0.-_tQ6x_6jp_8Q8g5yGaYSdB57M81jpKlo5O3zNpJTcs',
);

final expectedLoggedUser = User(userName: 'emilys', firstName: 'Emily', lastName: 'Johnson');
