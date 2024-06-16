class Property {
  String label;
  String name;
  String price;
  String location;
  String sqm;
  String review;
  String description;
  String frontImage;
  String ownerImage;
  List<String> images;

  Property(
      this.label,
      this.name,
      this.price,
      this.location,
      this.sqm,
      this.review,
      this.description,
      this.frontImage,
      this.ownerImage,
      this.images);
}

List<Property> getPropertyList() {
  return <Property>[
    Property(
      "VENTA",
      "Villa San Salvador",
      "350,000.00",
      "San Salvador",
      "2,456",
      "4.4",
      "La vida es fácil en esta impresionante residencia contemporánea generosamente proporcionada con vistas al lago y al océano, ubicada a un paseo nivelado de la arena y el mar.",
      "assets/images/house_01.jpg",
      "assets/images/owner.jpg",
      [
        "assets/images/bath_room.jpg",
        "assets/images/kitchen.jpg",
        "assets/images/swimming_pool.jpg",
        "assets/images/bed_room.jpg",
        "assets/images/living_room.jpg",
      ],
    ),
    Property(
      "ALQUILER",
      "Casa Santa Tecla",
      "1,500.00",
      "Santa Tecla",
      "3,300",
      "4.6",
      "La vida es fácil en esta impresionante residencia contemporánea generosamente proporcionada con vistas al lago y al océano, ubicada a un paseo nivelado de la arena y el mar.",
      "assets/images/house_04.jpg",
      "assets/images/owner.jpg",
      [
        "assets/images/bath_room.jpg",
        "assets/images/kitchen.jpg",
        "assets/images/swimming_pool.jpg",
        "assets/images/bed_room.jpg",
        "assets/images/living_room.jpg",
      ],
    ),
    Property(
      "ALQUILER",
      "Casa Libertad",
      "1,200.00",
      "La Libertad",
      "2,100",
      "4.1",
      "La vida es fácil en esta impresionante residencia contemporánea generosamente proporcionada con vistas al lago y al océano, ubicada a un paseo nivelado de la arena y el mar.",
      "assets/images/house_02.jpg",
      "assets/images/owner.jpg",
      [
        "assets/images/bath_room.jpg",
        "assets/images/kitchen.jpg",
        "assets/images/swimming_pool.jpg",
        "assets/images/bed_room.jpg",
        "assets/images/living_room.jpg",
      ],
    ),
    Property(
      "VENTA",
      "Casa San Miguel",
      "450,000.00",
      "San Miguel",
      "4,100",
      "4.5",
      "La vida es fácil en esta impresionante residencia contemporánea generosamente proporcionada con vistas al lago y al océano, ubicada a un paseo nivelado de la arena y el mar.",
      "assets/images/house_03.jpg",
      "assets/images/owner.jpg",
      [
        "assets/images/bath_room.jpg",
        "assets/images/kitchen.jpg",
        "assets/images/swimming_pool.jpg",
        "assets/images/bed_room.jpg",
        "assets/images/living_room.jpg",
      ],
    ),
    Property(
      "VENTA",
      "Casa Aventura",
      "520,000.00",
      "Santa Ana",
      "3,100",
      "4.2",
      "La vida es fácil en esta impresionante residencia contemporánea generosamente proporcionada con vistas al lago y al océano, ubicada a un paseo nivelado de la arena y el mar.",
      "assets/images/house_05.jpg",
      "assets/images/owner.jpg",
      [
        "assets/images/bath_room.jpg",
        "assets/images/kitchen.jpg",
        "assets/images/swimming_pool.jpg",
        "assets/images/bed_room.jpg",
        "assets/images/living_room.jpg",
      ],
    ),
    Property(
      "VENTA",
      "Casa Norte",
      "350,000.00",
      "San Salvador",
      "3,700",
      "4.0",
      "La vida es fácil en esta impresionante residencia contemporánea generosamente proporcionada con vistas al lago y al océano, ubicada a un paseo nivelado de la arena y el mar.",
      "assets/images/house_06.jpg",
      "assets/images/owner.jpg",
      [
        "assets/images/bath_room.jpg",
        "assets/images/kitchen.jpg",
        "assets/images/swimming_pool.jpg",
        "assets/images/bed_room.jpg",
        "assets/images/living_room.jpg",
      ],
    ),
    Property(
      "ALQUILER",
      "Residencia Rasmus",
      "2,900.00",
      "San Salvador",
      "2,700",
      "4.3",
      "La vida es fácil en esta impresionante residencia contemporánea generosamente proporcionada con vistas al lago y al océano, ubicada a un paseo nivelado de la arena y el mar.",
      "assets/images/house_07.jpg",
      "assets/images/owner.jpg",
      [
        "assets/images/bath_room.jpg",
        "assets/images/kitchen.jpg",
        "assets/images/swimming_pool.jpg",
        "assets/images/bed_room.jpg",
        "assets/images/living_room.jpg",
      ],
    ),
    Property(
      "ALQUILER",
      "Casa Simone",
      "3,900.00",
      "Santa Tecla",
      "3,700",
      "4.4",
      "La vida es fácil en esta impresionante residencia contemporánea generosamente proporcionada con vistas al lago y al océano, ubicada a un paseo nivelado de la arena y el mar.",
      "assets/images/house_08.jpg",
      "assets/images/owner.jpg",
      [
        "assets/images/bath_room.jpg",
        "assets/images/kitchen.jpg",
        "assets/images/swimming_pool.jpg",
        "assets/images/bed_room.jpg",
        "assets/images/living_room.jpg",
      ],
    ),
  ];
}
