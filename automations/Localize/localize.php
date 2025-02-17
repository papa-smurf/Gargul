<?php

$gargulDIR = __DIR__ . '/../../';

// Replace all chat translation data
(function($gargulDIR){
    // Fetch enUS chat enTranslations
    $chatTranslations = (function ($gargulDIR){
        $chatTranslations = file_get_contents($gargulDIR . '/Data/Localizations/chat.lua');
        $enUsStart = strpos($chatTranslations, 'enUS = {');
        $enUsEnd = strpos($chatTranslations, '--[[ deDE ]]');

        $chatTranslations = substr($chatTranslations, $enUsStart + strlen($enUsStart), $enUsEnd - $enUsStart);
        return extractLabelsAndTranslationsFromCollection($chatTranslations, ',');
    })($gargulDIR);

    // Sort from longest label to shortest, that way we replace the correct labels
    uksort($chatTranslations, "sortLongestToShortest");

    // Replace translation usages
    $sources = [ 'Classes', 'Interface' ];
    foreach ($sources as $source) {
        foreach(glob($gargulDIR . $source . '/*.lua', GLOB_BRACE) as $file) {
            $fileContent = file_get_contents($file);
    
            foreach ($chatTranslations as $label => $translation) {
                $fileContent = str_replace("L.CHAT.{$label}", "L.CHAT[{$translation}]", $fileContent);
            }

            file_put_contents($file, $fileContent);
        }
    }

    // Update chat file
    $chatFile = $gargulDIR . 'Data/Localizations/chat.lua';
    $fileContent = file_get_contents($chatFile);
    foreach ($chatTranslations as $label => $translation) {
        $fileContent = str_replace($label, "[{$translation}]", $fileContent);
    }
    file_put_contents($chatFile, $fileContent);
})($gargulDIR);

// Extract labels and enTranslations from en.lua
// $enTranslations = file_get_contents($gargulDIR . '/Data/Localizations/en.lua');

// $translationsByLabel = array_merge(
//     extractLabelsAndTranslationsFromCollection($chatTranslations, ','),
//     extractLabelsAndTranslationsFromCollection($enTranslations, ';'),
// );

// dd($translationsByLabel);

function extractLabelsAndTranslationsFromCollection($collection, $lineCloser)
{
    preg_match_all('/[A-Z_]+ = ("|\[){1}/', $collection, $matches, PREG_OFFSET_CAPTURE);
    $translationsByLabel = [];
    $labels = $matches[0];

    foreach ($labels as $key => $match) {
        $opener = substr($match[0], -1, 1);
        $openerIsQuote = $opener === '"';
        $closer = $openerIsQuote ? '"' : ']]';
        $closer .= $lineCloser;

        // We want the translations including their envelope characters
        $translationStart = strlen($match[0]) + $match[1];
        $translationStart -= $openerIsQuote ? 1 : 2;
        $translationEnd = strpos($collection, $closer, $translationStart);
        $translationEnd += $openerIsQuote ? 1 : 2;

        $translation = substr($collection, $translationStart, $translationEnd - $translationStart);
        $label = str_replace(' ', '', $match[0]);
        $label = substr($label, 0, -2);

        $translationsByLabel[$label] = $translation;
    }

    return $translationsByLabel;
}

// Sort array by key length DESC
function sortLongestToShortest($a, $b)
{
    return strlen($b) - strlen($a);
}

function dd($any)
{
    var_dump($any);
    die;
}