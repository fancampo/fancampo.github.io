<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:env="http://panax.io/state/environment" xmlns:xo="http://panax.io/xover" xmlns:xlink="http://www.w3.org/1999/xlink">
	<xsl:import href="keys.xslt"/>
	<xsl:import href="common.xslt"/>
	<xsl:key name="data" match="data[contains(translate(@name,'1234567890','##########'),'#')]" use="''"/>

	<xsl:template match="/">
		<div>
			<style>
				<![CDATA[

        /* TIMELINE
–––––––––––––––––––––––––––––––––––––––––––––––––– */

        .timeline ul {
            background: url(./assets/img/campo_hd.jpg);
            padding: 50px 0;
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center center;
            padding: 50px 0;
        }

        .timeline ul li {
            list-style-type: none;
            position: relative;
            width: 6px;
            margin: 0 auto;
            padding-top: 50px;
            background: var(--fancampovida-tone-5);
        }

        .timeline ul li::after {
            content: "";
            position: absolute;
            left: 50%;
            bottom: 0;
            transform: translateX(-50%);
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background: inherit;
            z-index: 1;
        }

        .timeline ul li div {
            position: relative;
            bottom: 0;
            width: 400px;
            padding: 15px;
            background: var(--fancampovida-silver-cloud);
            color: white;
			font-size: large;
        }

        .timeline ul li div::before {
            content: "";
            position: absolute;
            bottom: 7px;
            width: 0;
            height: 0;
            border-style: solid;
        }

        .timeline ul li:nth-child(odd) div {
            left: 45px;
        }

        .timeline ul li:nth-child(odd) div::before {
            left: -15px;
            border-width: 8px 16px 8px 0;
            border-color: transparent var(--fancampovida-silver-cloud) transparent transparent;
        }

        .timeline ul li:nth-child(even) div {
            left: -439px;
        }

        .timeline ul li:nth-child(even) div::before {
            right: -15px;
            border-width: 8px 0 8px 16px;
            border-color: transparent transparent transparent var(--fancampovida-silver-cloud);
        }

        time {
            display: block;
            font-size: 1.2rem;
            font-weight: bold;
            margin-bottom: 8px;
        }


        /* EFFECTS
–––––––––––––––––––––––––––––––––––––––––––––––––– */

        .timeline ul li::after {
            transition: background 0.5s ease-in-out;
        }

        .timeline ul li.in-view::after {
            background: var(--fancampovida-accent);
        }

        .timeline ul li div {
            visibility: hidden;
            opacity: 0;
            transition: all 0.5s ease-in-out;
        }

        .timeline ul li:nth-child(odd) div {
            transform: translate3d(200px, 0, 0);
        }

        .timeline ul li:nth-child(even) div {
            transform: translate3d(-200px, 0, 0);
        }

        .timeline ul li.in-view div {
            transform: none;
            visibility: visible;
            opacity: 1;
        }


        /* GENERAL MEDIA QUERIES
–––––––––––––––––––––––––––––––––––––––––––––––––– */

        @media screen and (max-width: 900px) {
            .timeline ul li div {
                width: 250px;
            }

            .timeline ul li:nth-child(even) div {
                left: -289px;
                /*250+45-6*/
            }
        }

        @media screen and (max-width: 600px) {
            .timeline ul li {
                margin-left: 20px;
            }

            .timeline ul li div {
                width: calc(100vw - 91px);
            }

            .timeline ul li:nth-child(even) div {
                left: 45px;
            }

            .timeline ul li:nth-child(even) div::before {
                left: -15px;
                border-width: 8px 16px 8px 0;
                border-color: transparent var(--fancampovida-silver-cloud) transparent transparent;
            }
        }


        /* EXTRA/CLIP PATH STYLES
–––––––––––––––––––––––––––––––––––––––––––––––––– */
        .timeline-clippy ul li::after {
            width: 40px;
            height: 40px;
            border-radius: 0;
        }

        .timeline-rhombus ul li::after {
            clip-path: polygon(50% 0%, 100% 50%, 50% 100%, 0% 50%);
        }

        .timeline-rhombus ul li div::before {
            bottom: 12px;
        }

        .timeline-star ul li::after {
            clip-path: polygon( 50% 0%, 61% 35%, 98% 35%, 68% 57%, 79% 91%, 50% 70%, 21% 91%, 32% 57%, 2% 35%, 39% 35% );
        }

        .timeline-heptagon ul li::after {
            clip-path: polygon( 50% 0%, 90% 20%, 100% 60%, 75% 100%, 25% 100%, 0% 60%, 10% 20% );
        }

        .timeline-infinite ul li::after {
            animation: scaleAnimation 2s infinite;
        }

        @keyframes scaleAnimation {
            0% {
                transform: translateX(-50%) scale(1);
            }

            50% {
                transform: translateX(-50%) scale(1.25);
            }

            100% {
                transform: translateX(-50%) scale(1);
            }
        }
			]]>
			</style>
			<xsl:variable name="cover">
				<xsl:choose>
					<xsl:when test="key('data','cover')">
						<xsl:value-of select="normalize-space(translate(substring-before(concat(key('data','cover'),';'),';'),'\','/'))"/>
					</xsl:when>
					<xsl:otherwise>img/cover.jpg</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<div class="section-title">
				<h2 style="text-transform: capitalize">
					Nuestra <span style="color: var(--fancampovida-creen-snow)">historia</span>
				</h2>
			</div>
			<section class="timeline">
				<ul>
					<xsl:apply-templates select="key('data','')"/>
				</ul>
			</section>
			<script>
				<![CDATA[
				(function () {
				"use strict";

				// define variables
				var items = document.querySelectorAll(".timeline li");

				// check if an element is in viewport
				// http://stackoverflow.com/questions/123999/how-to-tell-if-a-dom-element-is-visible-in-the-current-viewport
				function isElementInViewport(el) {
				var rect = el.getBoundingClientRect();
				return (
				rect.top >= 0 &&
				rect.left >= 0 &&
				rect.bottom <=
				(window.innerHeight || document.documentElement.clientHeight) &&
				rect.right <= (window.innerWidth || document.documentElement.clientWidth)
				);
				}

				function callbackFunc() {
				for (var i = 0; i < items.length; i++) {
                    if (isElementInViewport(items[i])) {
                        items[i].classList.add("in-view");
                    }
                }
            }

            // listen for events
            window.addEventListener("load", callbackFunc);
            window.addEventListener("resize", callbackFunc);
            window.addEventListener("scroll", callbackFunc);
        })();]]>
			</script>
		</div>
	</xsl:template>

	<xsl:template match="data">
		<li>
			<div>
				<time>
					<xsl:apply-templates select="@name"/>
				</time>
				<xsl:apply-templates select="value"/>
			</div>
		</li>
	</xsl:template>
</xsl:stylesheet>