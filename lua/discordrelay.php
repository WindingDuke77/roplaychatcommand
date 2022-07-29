<?php
	if (!isset($_POST["url"])) {
			return;
	}

	$webhookurl = $_POST["url"];

	$timestamp = date("c", strtotime("now"));
	$json_data = "";
	
	$json_data = json_encode([
		"content" => $_POST["ping"],
		"username" => $_POST["author"],
		"avatar_url" => $_POST["authorimg"],
		"embeds" => [
			[
				"title" => $_POST["title"],
				"type" => "rich",
				"timestamp" => $timestamp,
				"color" => hexdec($_POST["bar_color"]),
				"description" => $_POST["description"]
			]
		]
	], JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE );
		


	$ch = curl_init( $webhookurl );
	curl_setopt( $ch, CURLOPT_HTTPHEADER, array('Content-type: application/json'));
	curl_setopt( $ch, CURLOPT_POST, 1);
	curl_setopt( $ch, CURLOPT_POSTFIELDS, $json_data);
	curl_setopt( $ch, CURLOPT_FOLLOWLOCATION, 1);
	curl_setopt( $ch, CURLOPT_HEADER, 0);
	curl_setopt( $ch, CURLOPT_RETURNTRANSFER, 1);

	curl_exec( $ch );
	curl_close( $ch );

?>