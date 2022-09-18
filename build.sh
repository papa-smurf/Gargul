DIRNAME="Gargul";

mkdir -p "${DIRNAME}";

cp -R Assets "${DIRNAME}/Assets";
cp -R Classes "${DIRNAME}/Classes";
cp -R Data "${DIRNAME}/Data";
cp -R Interface "${DIRNAME}/Interface";
cp -R Libs "${DIRNAME}/Libs";
cp LICENSE "${DIRNAME}/LICENSE";
cp README.md "${DIRNAME}/README.md";
cp bootstrap.lua "${DIRNAME}/bootstrap.lua";
cp Test.lua "${DIRNAME}/Test.lua";
cp Gargul.toc "${DIRNAME}/Gargul.toc";
cp libraries.xml "${DIRNAME}/libraries.xml";

7z a Gargul.zip "${DIRNAME}" -mx9

rm -rf "${DIRNAME}";