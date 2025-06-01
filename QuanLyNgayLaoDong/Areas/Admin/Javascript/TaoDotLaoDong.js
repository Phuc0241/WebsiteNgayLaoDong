document.addEventListener("DOMContentLoaded", function () {
    // Tự động ẩn thông báo sau 3 giây
    setTimeout(function () {
        document.querySelectorAll(".alert").forEach(function (alert) {
            alert.style.transition = "opacity 0.5s ease";
            alert.style.opacity = "0";
            setTimeout(() => alert.remove(), 500);
        });
    }, 3000);

    const rowsPerPage = 5;
    const table = document.getElementById("dotLaoDongTable");
    const tbody = table?.querySelector("tbody");
    let allRows = tbody ? Array.from(tbody.querySelectorAll("tr")) : [];
    const pagination = document.getElementById("pagination");
    const searchInput = document.getElementById("searchInput");
    const filterDotLaoDong = document.getElementById("filterDotLaoDong");
    const filterKhuVuc = document.getElementById("filterKhuVuc");
    const filterBuoi = document.getElementById("filterBuoi");
    const filterLoaiLaoDong = document.getElementById("filterLoaiLaoDong");
    const filterThoiGian = document.getElementById("filterThoiGian");

    let currentPage = 1;

    // Chuẩn hóa chuỗi để tìm kiếm không phân biệt dấu và chữ cái
    function normalize(str) {
        return str
            .normalize("NFD")
            .replace(/[\u0300-\u036f]/g, "")
            .toLowerCase()
            .trim();
    }

    // Lọc các hàng dựa trên tiêu chí bộ lọc và tìm kiếm
    function getFilteredRows() {
        const keyword = normalize(searchInput?.value || "");
        const selectedDot = normalize(filterDotLaoDong?.value || "");
        const selectedKhuVuc = normalize(filterKhuVuc?.value || "");
        const selectedBuoi = normalize(filterBuoi?.value || "");
        const selectedLoai = normalize(filterLoaiLaoDong?.value || "");
        const selectedThoiGian = normalize(filterThoiGian?.value || "");

        return allRows.filter(row => {
            const dotLaoDong = normalize(row.querySelector('[data-dot]')?.getAttribute('data-dot') || "");
            const ngayLaoDong = normalize(row.querySelector('[data-ngay]')?.getAttribute('data-ngay') || "");
            const khuVuc = normalize(row.querySelector('[data-khu-vuc]')?.getAttribute('data-khu-vuc') || "");
            const buoi = normalize(row.querySelector('[data-buoi]')?.getAttribute('data-buoi') || "");
            const loaiLaoDong = normalize(row.querySelector('[data-loai]')?.getAttribute('data-loai') || "");
            const giaTri = normalize(row.querySelector('[data-gia-tri]')?.getAttribute('data-gia-tri') || "");
            const moTa = normalize(row.querySelector('[data-mo-ta]')?.getAttribute('data-mo-ta') || "");
            const thoiGian = normalize(row.querySelector('[data-thoi-gian]')?.getAttribute('data-thoi-gian') || "");
            const soLuongSinhVien = normalize(row.querySelector('[data-so-luong-sinh-vien]')?.getAttribute('data-so-luong-sinh-vien') || "");

            const matchesKeyword = keyword ? (
                dotLaoDong.includes(keyword) ||
                ngayLaoDong.includes(keyword) ||
                khuVuc.includes(keyword) ||
                buoi.includes(keyword) ||
                loaiLaoDong.includes(keyword) ||
                giaTri.includes(keyword) ||
                moTa.includes(keyword) ||
                thoiGian.includes(keyword) ||
                soLuongSinhVien.includes(keyword)
            ) : true;

            const matchesDot = selectedDot ? dotLaoDong.includes(selectedDot) : true;
            const matchesKhuVuc = selectedKhuVuc ? khuVuc.includes(selectedKhuVuc) : true;
            const matchesBuoi = selectedBuoi ? buoi.includes(selectedBuoi) : true;
            const matchesLoai = selectedLoai ? loaiLaoDong.includes(selectedLoai) : true;
            const matchesThoiGian = selectedThoiGian ? thoiGian.includes(selectedThoiGian) : true;

            return matchesKeyword && matchesDot && matchesKhuVuc && matchesBuoi && matchesLoai && matchesThoiGian;
        });
    }

    // Cập nhật số thứ tự (STT) cho các hàng hiển thị
    function updateSTT(filteredRows) {
        filteredRows.forEach((row, index) => {
            row.children[0].textContent = index + 1 + (currentPage - 1) * rowsPerPage;
        });
    }

    // Hiển thị trang cụ thể
    function showPage(page, filteredRows) {
        currentPage = page;
        const start = (page - 1) * rowsPerPage;
        const end = start + rowsPerPage;

        allRows.forEach(row => row.style.display = "none");
        const visibleRows = filteredRows.slice(start, end);
        visibleRows.forEach(row => row.style.display = "");

        updateSTT(visibleRows);
        renderPagination(filteredRows.length);
    }

    // Render phân trang
    function renderPagination(totalItems) {
        if (!pagination) return;
        const totalPages = Math.ceil(totalItems / rowsPerPage);
        pagination.innerHTML = "";

        const prev = document.createElement("li");
        prev.className = "page-item" + (currentPage === 1 ? " disabled" : "");
        prev.innerHTML = `<a class="page-link" href="#">←</a>`;
        prev.addEventListener("click", (e) => {
            e.preventDefault();
            if (currentPage > 1) {
                currentPage--;
                showPage(currentPage, getFilteredRows());
            }
        });
        pagination.appendChild(prev);

        for (let i = 1; i <= totalPages; i++) {
            const li = document.createElement("li");
            li.className = "page-item" + (i === currentPage ? " active" : "");
            li.innerHTML = `<a class="page-link" href="#">${i}</a>`;
            li.addEventListener("click", (e) => {
                e.preventDefault();
                currentPage = i;
                showPage(currentPage, getFilteredRows());
            });
            pagination.appendChild(li);
        }

        const next = document.createElement("li");
        next.className = "page-item" + (currentPage === totalPages ? " disabled" : "");
        next.innerHTML = `<a class="page-link" href="#">→</a>`;
        next.addEventListener("click", (e) => {
            e.preventDefault();
            if (currentPage < totalPages) {
                currentPage++;
                showPage(currentPage, getFilteredRows());
            }
        });
        pagination.appendChild(next);
    }

    // Xuất file Excel với tất cả dữ liệu
    window.exportToExcel = async function () {
        try {
            // Lấy tất cả các dòng (kể cả đang bị ẩn)
            const allRows = Array.from(document.querySelectorAll("#dotLaoDongTable tbody tr"));

            const headers = Array.from(document.querySelectorAll("#dotLaoDongTable thead th"))
                .map(th => th.textContent.trim())
                .filter((_, index) => index !== 10); // Loại bỏ cột "Tác Vụ"

            const data = allRows.map(row => {
                return Array.from(row.children)
                    .filter((_, index) => index !== 10)
                    .map(cell => cell.textContent.trim());
            });

            const sheetData = [headers, ...data];

            const ws = XLSX.utils.aoa_to_sheet(sheetData);
            const wb = XLSX.utils.book_new();
            XLSX.utils.book_append_sheet(wb, ws, "DanhSachDotLaoDong");

            const wbout = XLSX.write(wb, { bookType: 'xlsx', type: 'array' });
            const blob = new Blob([wbout], { type: 'application/octet-stream' });

            if (window.showSaveFilePicker) {
                const handle = await window.showSaveFilePicker({
                    suggestedName: 'DanhSachDotLaoDong.xlsx',
                    types: [{
                        description: 'Excel Files',
                        accept: {
                            'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet': ['.xlsx']
                        }
                    }]
                });
                const writable = await handle.createWritable();
                await writable.write(blob);
                await writable.close();
            } else {
                saveAs(blob, 'DanhSachDotLaoDong.xlsx');
            }

            // Thông báo thành công
            const notificationContainer = document.createElement('div');
            notificationContainer.className = 'alert alert-success';
            notificationContainer.style.cssText = 'text-align: center; margin-bottom: 10px;';
            notificationContainer.textContent = 'Đã tải file Excel thành công!';
            document.querySelector('h2').insertAdjacentElement('afterend', notificationContainer);

            setTimeout(() => {
                notificationContainer.style.transition = 'opacity 0.5s ease';
                notificationContainer.style.opacity = '0';
                setTimeout(() => notificationContainer.remove(), 500);
            }, 3000);

        } catch (error) {
            console.error('Lỗi khi xuất file Excel:', error);
            const errorContainer = document.createElement('div');
            errorContainer.className = 'alert alert-danger';
            errorContainer.style.cssText = 'text-align: center; margin-bottom: 10px;';
            errorContainer.textContent = 'Đã ngắt xuất file';
            document.querySelector('h2').insertAdjacentElement('afterend', errorContainer);

            setTimeout(() => {
                errorContainer.style.transition = 'opacity 0.5s ease';
                errorContainer.style.opacity = '0';
                setTimeout(() => errorContainer.remove(), 500);
            }, 3000);
        }
    };

    // Xử lý sự kiện lọc và tìm kiếm
    if (searchInput) searchInput.addEventListener("input", () => showPage(1, getFilteredRows()));
    if (filterDotLaoDong) filterDotLaoDong.addEventListener("change", () => showPage(1, getFilteredRows()));
    if (filterKhuVuc) filterKhuVuc.addEventListener("change", () => showPage(1, getFilteredRows()));
    if (filterBuoi) filterBuoi.addEventListener("change", () => showPage(1, getFilteredRows()));
    if (filterLoaiLaoDong) filterLoaiLaoDong.addEventListener("change", () => showPage(1, getFilteredRows()));
    if (filterThoiGian) filterThoiGian.addEventListener("change", () => showPage(1, getFilteredRows()));

    // Khởi tạo trang đầu tiên
    if (table && tbody && pagination) {
        showPage(1, getFilteredRows());
    }
});