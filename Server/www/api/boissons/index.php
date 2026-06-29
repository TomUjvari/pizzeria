<?php

header("Content-Type: application/json; charset=UTF-8");

$json = array();

$json[] = array(
    'id' => 1,
    'title' => 'Coca Cola',
    'image' => 'coca.jpg',
    'sugar' => 40,
    'price' => 2.5
);
$json[] = array(
    'id' => 1,
    'title' => 'Perrier',
    'image' => 'perrier.jpg',
    'sugar' => 5,
    'price' => 1.5
);
$json[] = array(
    'id' => 1,
    'title' => 'Arizona Tea',
    'image' => 'arizona.jpg',
    'sugar' => 15,
    'price' => 2
);

echo json_encode($json);
