class UserUpdate {
    String? name, phone, city, street, addressInDetails, category, experience;
  UserUpdate({
    this.name,
    this.phone,
    this.city,
    this.street,
    this.addressInDetails,
    this.category,
    this.experience,
  });
  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (city != null) 'city': city,
      if (street != null) 'street': street,
      if (addressInDetails != null) 'address_in_details': addressInDetails,
      if (category != null) 'category': category,
      if (experience != null) 'experience': experience,
    };
  }  
}