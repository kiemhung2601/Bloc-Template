import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_total_response.dart';
part 'page_response.dart';
part 'base_page_response.freezed.dart';
part 'base_page_response.g.dart';

// Base Page response
// {
//   "data": {
//     "page": {
//       "content": [],
//       "first": true,
//       "last": true,
//       "number": 0,
//       "numberOfElements": 0,
//       "pageable": {
//         "offset": 0,
//         "pageNumber": 0,
//         "pageSize": 0,
//         "paged": true,
//         "sort": {
//           "sorted": true,
//           "unsorted": true
//         },
//         "unpaged": true
//       },
//       "size": 0,
//       "sort": {
//         "sorted": true,
//         "unsorted": true
//       },
//       "totalElements": 0,
//       "totalPages": 0
//     },
//     "totalValue": {
//       "total1": 0,
//       "total1Name": "string",
//       "total2": 0,
//       "total2Name": "string",
//       "total3": 0,
//       "total3Name": "string",
//       "total4": 0,
//       "total4Name": "string",
//       "total5": 0,
//       "total5Name": "string",
//       "total6": 0,
//       "total6Name": "string",
//       "total7": 0,
//       "total7Name": "string",
//       "total8": 0,
//       "total8Name": "string"
//     }
//   },
//   "executeDate": "yyyy-MM-dd'T'HH:mm:ss.SSS",
//   "statusCode": 0,
//   "statusValue": "string",
//   "success": true,
//   "token": "string"
// }

typedef Json = Map<String, dynamic>;
typedef FromJson<T> = T Function(Json json);
typedef ToJson<T> = Json Function(T data);
typedef Converter<T> = T Function(dynamic data);

class BasePageResponse<T> {
  const BasePageResponse({
    this.page = const PageResponse(),
    this.totalValue = const ListTotalResponse(),
  });

  factory BasePageResponse.fromJson(Json json, {FromJson<T>? fromJson}) => BasePageResponse<T>(
        page: json['page'] == null
            ? const PageResponse()
            : PageResponse.fromJson(
                json['page'] as Json,
                fromJson: fromJson,
              ),
        totalValue: json['totalValue'] == null
            ? const ListTotalResponse()
            : ListTotalResponse.fromJson(json['totalValue'] as Json),
      );

  final PageResponse<T> page;
  final ListTotalResponse totalValue;

  Json toJsonBase([ToJson<T>? toJson]) => <String, dynamic>{
        'page': page.toJson(toJson),
        'totalValue': totalValue.toJson(),
      };

  BasePageResponse<T> copyWith({
    PageResponse<T>? page,
    ListTotalResponse? totalValue,
  }) =>
      BasePageResponse(
        page: page ?? this.page,
        totalValue: totalValue ?? this.totalValue,
      );
}
