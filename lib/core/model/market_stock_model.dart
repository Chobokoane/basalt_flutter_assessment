class MarketStockModel {
  Pagination? pagination;
  List<Data>? data;

  MarketStockModel({this.pagination, this.data});

  MarketStockModel.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pagination {
  int? limit;
  int? offset;
  int? count;
  int? total;

  Pagination({this.limit, this.offset, this.count, this.total});

  Pagination.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    offset = json['offset'];
    count = json['count'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (limit != null) {
      data['limit'] = this.limit;
    }
    if (offset != null) {
      data['offset'] = this.offset;
    }
    if (limit != null) {
      data['limit'] = this.limit;
    }
    if (count != null) {
      data['count'] = this.count;
    }
    
    if (total != null) {
      data['total'] = this.total;
    }
    
    return data;
  }
}

class Data {
  String? name;
  String? symbol;
  StockExchange? stockExchange;

  Data({this.name,this.symbol, this.stockExchange});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    symbol = json['symbol'];
    stockExchange = json['stock_exchange'] != null
        ? new StockExchange.fromJson(json['stock_exchange'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (name != null) {
      data['name'] = this.name;
    }
    if (symbol != null) {
      data['symbol'] = this.symbol;
    }
    if (this.stockExchange != null) {
      data['stock_exchange'] = this.stockExchange!.toJson();
    }
    return data;
  }
}

class StockExchange {
  String? name;
  String? acronym;
  String? mic;
  String? country;
  String? countryCode;
  String? city;
  String? website;
  Timezone? timezone;

  StockExchange(
      {this.name,
      this.acronym,
      this.mic,
      this.country,
      this.countryCode,
      this.city,
      this.website,
      this.timezone});

  StockExchange.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    acronym = json['acronym'];
    mic = json['mic'];
    country = json['country'];
    countryCode = json['country_code'];
    city = json['city'];
    website = json['website'];
    timezone = json['timezone'] != null
        ? new Timezone.fromJson(json['timezone'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (name != null) {
      data['name'] = this.name;
    }
    if (acronym != null) {
      data['acronym'] = this.acronym;
    }
    if (mic != null) {
      data['mic'] = this.mic;
    }
    if (country != null) {
      data['country'] = this.country;
    }
    if (city != null) {
      data['city'] = this.city;
    }
    if (website != null) {
      data['website'] = this.website;
    }
    data['country_code'] = this.countryCode;
    if (this.timezone != null) {
      data['timezone'] = this.timezone!.toJson();
    }
    return data;
  }
}

class Timezone {
  String? timezone;
  String? abbr;
  String? abbrDst;

  Timezone({this.timezone, this.abbr, this.abbrDst});

  Timezone.fromJson(Map<String, dynamic> json) {
    timezone = json['timezone'];
    abbr = json['abbr'];
    abbrDst = json['abbr_dst'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
   if(timezone != null){
     data['timezone'] = this.timezone;
   }
   if(abbr != null){
     data['abbr'] = this.abbr;
   }
    data['abbr_dst'] = this.abbrDst;
    return data;
  }
}
