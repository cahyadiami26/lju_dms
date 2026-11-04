// Toast Notification
function showToast(message, type = 'success') {
    const container = document.getElementById('toastContainer');
    const colors = {
        success: 'bg-emerald-500',
        error: 'bg-red-500',
        warning: 'bg-amber-500',
        info: 'bg-blue-500'
    };
    const icons = {
        success: 'fa-check-circle',
        error: 'fa-times-circle',
        warning: 'fa-exclamation-triangle',
        info: 'fa-info-circle'
    };
    const toast = document.createElement('div');
    toast.className = `toast flex items-center gap-3 ${colors[type]} text-white px-4 py-3 rounded-lg shadow-lg text-sm font-medium min-w-[280px]`;
    toast.innerHTML = `<i class="fas ${icons[type]}"></i><span>${message}</span>`;
    container.appendChild(toast);
    setTimeout(() => {
        toast.style.transition = 'all 0.3s';
        toast.style.opacity = '0';
        toast.style.transform = 'translateX(100%)';
        setTimeout(() => toast.remove(), 300);
    }, 3500);
}

// Confirm Dialog
function confirmAction(message) {
    return new Promise(resolve => {
        resolve(window.confirm(message));
    });
}

// Delete confirmation
async function deleteItem(url, message) {
    if (await confirmAction(message || 'Apakah Anda yakin ingin menghapus item ini?')) {
        window.location.href = url;
    }
}

// Tag Input
document.addEventListener('DOMContentLoaded', function() {
    const tagInput = document.getElementById('tagInput');
    if (tagInput) {
        const tagContainer = document.getElementById('tagContainer');
        const hiddenInput = document.getElementById('tagsHidden');
        let tags = hiddenInput.value ? hiddenInput.value.split(',').filter(t => t.trim()) : [];

        function renderTags() {
            tagContainer.querySelectorAll('.tag-item').forEach(el => el.remove());
            tags.forEach((tag, i) => {
                const span = document.createElement('span');
                span.className = 'tag-item inline-flex items-center gap-1 bg-teal-50 text-teal-700 text-xs font-semibold px-2 py-1 rounded-md';
                span.innerHTML = `${tag}<button type="button" onclick="removeTag(${i})" class="text-teal-400 hover:text-red-500">&times;</button>`;
                tagContainer.insertBefore(span, tagInput);
            });
            hiddenInput.value = tags.join(',');
        }

        window.removeTag = function(i) {
            tags.splice(i, 1);
            renderTags();
        };

        tagInput.addEventListener('keydown', function(e) {
            if (e.key === 'Enter' || e.key === ',') {
                e.preventDefault();
                const val = tagInput.value.trim().replace(/,/g, '');
                if (val && !tags.includes(val)) {
                    tags.push(val);
                    tagInput.value = '';
                    renderTags();
                }
            }
        });

        renderTags();
    }
});

// Signature Pad Setup
let signaturePad = null;
document.addEventListener('DOMContentLoaded', function() {
    const canvas = document.getElementById('signatureCanvas');
    if (canvas && typeof SignaturePad !== 'undefined') {
        signaturePad = new SignaturePad(canvas, {
            backgroundColor: 'rgb(255,255,255)',
            penColor: 'rgb(15,76,117)',
            minWidth: 1,
            maxWidth: 2.5
        });
        function resizeCanvas() {
            const ratio = Math.max(window.devicePixelRatio || 1, 1);
            canvas.width = canvas.offsetWidth * ratio;
            canvas.height = canvas.offsetHeight * ratio;
            canvas.getContext('2d').scale(ratio, ratio);
            signaturePad.clear();
        }
        window.addEventListener('resize', resizeCanvas);
        resizeCanvas();
    }
});

function clearSignature() {
    if (signaturePad) signaturePad.clear();
}

function getSignatureData() {
    if (signaturePad && !signaturePad.isEmpty()) {
        return signaturePad.toDataURL('image/png');
    }
    return null;
}