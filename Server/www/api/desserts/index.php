<?php

header("Content-Type: application/json; charset=UTF-8");

$json = array();

$json[] = array(
    'id' => 1,
    'title' => 'Muffin',
    'image' => 'muffin.jpg',
    'price' => 3
);
$json[] = array(
    'id' => 1,
    'title' => 'Cookie',
    'image' => 'cookie.jpg',
    'price' => 2
);
$json[] = array(
    'id' => 1,
    'title' => 'Glace à la vanille',
    'image' => 'glace-vanille.jpg',
    'price' => 2
);

echo json_encode($json);
