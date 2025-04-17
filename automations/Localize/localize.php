<?php

// @TODO: This is an ugly but temporary utility file used to replace localizations

const TESTMODE = false;

const REPLACE_CHAT_TRANSLATIONS = false;
const REPLACE_TRANSLATIONS = true;

$gargulDIR = __DIR__ . '/../../';

$allLuaFiles = iterator_to_array(
    new RegexIterator(
        new RecursiveIteratorIterator(
            new RecursiveDirectoryIterator($gargulDIR)
        ),
        '/\.lua$/i'
    )
);
$allLuaFiles = array_map(fn($f) => $f->getPathname(), iterator_to_array($allLuaFiles));

// Replace all chat translation data
(function($gargulDIR, $allLuaFiles){
    if (!REPLACE_CHAT_TRANSLATIONS) {
        return;
    }

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
    foreach ($allLuaFiles as $file) {
        echo $file . "\n";
        $fileContent = file_get_contents($file);

        foreach ($chatTranslations as $label => $translation) {
            $fileContent = str_replace("L.CHAT.{$label}", "L.CHAT[{$translation}]", $fileContent);
        }

        file_put_contents($file, $fileContent);
    }

    // Update chat file
    $chatFile = $gargulDIR . 'Data/Localizations/chat.lua';
    $fileContent = file_get_contents($chatFile);
    foreach ($chatTranslations as $label => $translation) {
        $fileContent = str_replace($label, "[{$translation}]", $fileContent);
    }
    file_put_contents($chatFile, $fileContent);
})($gargulDIR, $allLuaFiles);

// Replace all non-chat translation data
(function($gargulDIR, $allLuaFiles) {
    if (!REPLACE_TRANSLATIONS) {
        return;
    }

    // Fetch enUS chat enTranslations
    $englishTranslations = (function ($gargulDIR){
        $englishTranslations = file_get_contents($gargulDIR . '/Data/Localizations/en.lua');
        return extractLabelsAndTranslationsFromCollection($englishTranslations, ';');
    })($gargulDIR);

    // Sort from longest label to shortest, that way we replace the correct labels
    uksort($englishTranslations, "sortLongestToShortest");

    // Replace translation usages
    foreach ($allLuaFiles as $file) {
        $originalContent = file_get_contents($file);
        $fileContent = $originalContent;
        $isTranslationFile = strpos($file, '\\Data\\Localizations\\') !== false;

        $somethingWasReplaced = false;
        foreach ($englishTranslations as $label => $translation) {
            if ($isTranslationFile) {
                $fileContent = str_replace("L.{$label}", "L[{$translation}]", $fileContent);
                continue;
            }

            $fileContent = str_replace("(L.{$label}", "(L[{$translation}]", $fileContent);
            $fileContent = str_replace(" L.{$label}", " L[{$translation}]", $fileContent);
            $fileContent = str_replace("\tL.{$label}", "\tL[{$translation}]", $fileContent);
        }

        file_put_contents($file, $fileContent);

        if (TESTMODE && $originalContent != $fileContent) {
            echo $file . "\n";
            die;
        }
    }
})($gargulDIR, $allLuaFiles);

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
        $translationStart = 1;
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