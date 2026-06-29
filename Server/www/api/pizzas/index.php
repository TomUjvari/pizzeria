<?php

header("Content-Type: application/json; charset=UTF-8");

$json = array();

$json[] = array(
    'id' => 1,
    'title' => 'Jambon',
    'garniture' => 'Emmental, mozzarella, jambon, olives, origan',
    'image' => 'jambon.jpg',
    'price' => 7.5
);
$json[] = array(
    'id' => 1,
    'title' => 'Barbecue',
    'garniture' => 'Mozzarella, poulet, bœuf haché, oignons rouges',
    'image' => 'bbq.jpg',
    'price' => 9
);
$json[] = array(
    'id' => 1,
    'title' => 'Chèvre-miel',
    'garniture' => 'Fromage de chèvre, miel, noix, mozzarella',
    'image' => 'chevre-miel.jpg',
    'price' => 9
);
$json[] = array(
    'id' => 4,
    'title' => 'Végétarienne',
    'garniture' => 'Mozzarella, champignons, poivrons, tomates, oignons, olives',
    'image' => 'veggie.jpg',
    'price' => 8
);
$json[] = array(
    'id' => 2,
    'title' => 'Hawaï',
    'garniture' => 'Ananas, mozzarella, jambon',
    'image' => 'hawai.jpg',
    'price' => 100
);

echo json_encode($json);
