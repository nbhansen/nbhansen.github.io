// Initialize Mermaid diagrams
document.addEventListener('DOMContentLoaded', function() {
    // Import Mermaid from CDN
    const script = document.createElement('script');
    script.src = 'https://cdn.jsdelivr.net/npm/mermaid@10.9.0/dist/mermaid.min.js';
    script.onload = function() {
        // Initialize Mermaid with dark theme to match your site
        mermaid.initialize({
            startOnLoad: true,
            theme: 'dark',
            themeVariables: {
                primaryColor: '#EACD00',
                primaryTextColor: '#F6F2ED',
                primaryBorderColor: '#EACD00',
                lineColor: '#F6F2ED',
                sectionBkgColor: '#1C1D1F',
                altSectionBkgColor: '#86918A',
                gridColor: '#F6F2ED',
                secondaryColor: '#86918A',
                tertiaryColor: '#1C1D1F'
            }
        });
        
        // Find all mermaid code blocks and convert them
        const mermaidBlocks = document.querySelectorAll('pre code.language-mermaid');
        mermaidBlocks.forEach(function(block, index) {
            const mermaidCode = block.textContent;
            const mermaidDiv = document.createElement('div');
            mermaidDiv.className = 'mermaid';
            mermaidDiv.textContent = mermaidCode;
            mermaidDiv.id = 'mermaid-' + index;
            
            // Replace the code block with the mermaid div
            block.parentNode.parentNode.replaceChild(mermaidDiv, block.parentNode);
        });
    };
    document.head.appendChild(script);
});