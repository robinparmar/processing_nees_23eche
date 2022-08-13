/*
	This is an implementation of Georg Nees' "23-Ecke (Polygon of 23 vertices)", 1964. Info here:
	http://dada.compart-bremen.de/item/artwork/639

	This relates to my work translating Max Bense (who taught Nees philosophy). Check that out here:
	https://www.theatreofnoise.com/2022/08/aesthetica-by-max-bense-partial.html

	Original algorithm at end of file.

	(c) 2022 Robin Parmar. MIT License.
*/

int x, y;
int countX, countY, margin, sizer;

PFont f;

void setup() {
    // use whatever architectural typeface you have
	f = createFont("Lekton", 14);
	textFont(f);
    fullScreen();
    nees();
}

void draw() {}

// tap spacebar to draw again
void keyPressed() {
    if (key == ' ') {
	    nees();
    }
}

void nees() {
    // all we have is a plotter :-)
    background(255);
    noFill();
    stroke(0);

    // size of each grid space
    sizer = 100;

    // amount of whitespace between grid spaces
    margin = 40;
 
 	// how many blocks can we fit? (non-greedy approach)
    countX = (width / (sizer + margin)) -1;
    countY = (height / (sizer + margin)) -1;
  
    // create our grid
    for (int i=0; i<countX; i++) {
        for (int j=0; j<countY; j++) {
            pushMatrix();
            	// it's easiest to translate from origin for each block
                translate(i*(sizer+margin), j*(sizer+margin));
                translate(2*margin, 2*margin);
                
                // each shape has 23 line segments
        		beginShape();
        			// one coordinate changes for each vertex
        			// but a diagonal line can occur when closing the shape
            		y = 0;
                    for (int t=0; t<23; t++) {
        	            x = int(random(i, sizer));
                        vertex(x, y);
            	        y = int(random(j, sizer));
        	            vertex(x, y);
            		}
                endShape(CLOSE);
            popMatrix();
        }
    }

    // position is a hack, sorry
    fill(40);
    text("23-Ecke Remix (2022) by Robin Parmar", width-450, height-120);

    saveFrame(tfile());
}

String tfile() {
    String t = String.format("screenshot/nees-%s.png", millis());
    return t;
}

/*
Published algorithm from:
http://dada.compart-bremen.de/item/algorithm/5

This isn't complete, likely because it relies on ALGOL libraries.
Also, there's at least one typo.
Hence my own algorithm is interpretive rather than a direct copy. 

(1) für M von 0 (in Schritten von 15)
(2) bis 285:
(3) {für U von 0 (in Schritten von 15)
(4) bis 195:
(5) [JA wird M + 1; JE wird M+14;
(6) A wird J; X wird A;
(7) JA wird U + 1; JE wird U + 14;
(8) B wird J; Y wird B; P;
(9) für T von 1 (in Schritten von 1)
(10) bis 11:
(11) JA wird M + 1; JE wird M + 14;
(12) X wird J; S;
(13) JA wird U + 1; JE wird U + 14;
(14) Y wird J; S);
(15) X wird A; Y wird B; S ]}

J steht für den Zufallsgenerator
Längeneinheit = 1 Millimeter
*/
