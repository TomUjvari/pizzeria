<?php

header("Content-Type: application/json; charset=UTF-8");

$json = array();

$json[] = array(
    'id' => 1,
    'title' => 'Salade César',
    'ingredients' => 'Salade romaine, poulet grillé, croûtons, parmesan, sauce César',
    'image' => 'cesar.jpg',
    'price' => 6
);

$json[] = array(
    'id' => 2,
    'title' => 'Salade de pâtes',
    'ingredients' => 'Pâtes, tomates cerises, mozzarella, jambon, olives, basilic, vinaigrette',
    'image' => 'pates.jpg',
    'price' => 7
);

echo json_encode($json);