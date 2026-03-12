document.addEventListener('DOMContentLoaded', () => {
    // Navigasi Smooth Scroll yang efisien
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            const targetId = this.getAttribute('href');
            
            // Bypass jika href hanya "#"
            if (targetId === '#') return;

            const targetElement = document.querySelector(targetId);
            
            if (targetElement) {
                e.preventDefault();
                const headerOffset = 70;
                const elementPosition = targetElement.getBoundingClientRect().top;
                const offsetPosition = elementPosition + window.pageYOffset - headerOffset;

                window.scrollTo({
                    top: offsetPosition,
                    behavior: "smooth"
                });
            }
        });
    });

    // Simulasi interaksi unduhan (Ganti dengan tautan asli saat produksi)
    const downloadBtns = document.querySelectorAll('a[href="#download"]');
    downloadBtns.forEach(btn => {
        btn.addEventListener('click', (e) => {
            e.preventDefault();
            console.log("Logika pengalihan toko aplikasi dijalankan.");
            alert("Sistem akan mengarahkan ke halaman Google Play atau App Store. (Tautan belum dikonfigurasi)");
        });
    });
});