class Pager {
  int? page;
  int? pageCount;
  int? total;
  int? pageSize;
  String? nextPage;

  Pager({
    this.page,
    this.pageCount,
    this.total,
    this.pageSize,
    this.nextPage,
  });

  @override
  String toString() {
    return 'Pager(page: $page, pageCount: $pageCount, total: $total, pageSize: $pageSize, nextPage: $nextPage)';
  }

  factory Pager.fromJson(Map<String, dynamic> json) => Pager(
        page: json['page'] as int?,
        pageCount: json['pageCount'] as int?,
        total: json['total'] as int?,
        pageSize: json['pageSize'] as int?,
        nextPage: json['nextPage'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'page': page,
        'pageCount': pageCount,
        'total': total,
        'pageSize': pageSize,
        'nextPage': nextPage,
      };

  Pager copyWith({
    int? page,
    int? pageCount,
    int? total,
    int? pageSize,
    String? nextPage,
  }) {
    return Pager(
      page: page ?? this.page,
      pageCount: pageCount ?? this.pageCount,
      total: total ?? this.total,
      pageSize: pageSize ?? this.pageSize,
      nextPage: nextPage ?? this.nextPage,
    );
  }
}
