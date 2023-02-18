#include <iostream>
#include <fstream>
#include <cmath>
#include <vector>
#include <complex>
using namespace std;

#define pi 3.14159265358979323846
#define nmax 2000
#define mmax 200

int n;
double xme, xmh, xm, nbeta, xn;
double omega, dam;
double xnue, xnuh;
vector < double > s(nmax), w(nmax);
double xieh;
vector < double > selfe(nmax), selfh(nmax), gammb(nmax);

double funci(double ideh, double xnuy) {
    double xmi = (1 - ideh) * xme + ideh * xmh, temp = 0;
    for (int i = 1; i <= n; i++) {
        double selfi = (1 - ideh) * selfe[i] + ideh * selfh[i];
        double ek = nbeta * (abs(s[i]) * xm / xmi + selfi - xnuy);
        double ek1 = nbeta * (abs(s[i]) * xm / xmi - selfi + xnuy);
        double fe = 1. / (exp(ek) + 1);
        double fh = 1. / (exp(ek1) + 1);
        //double ek = nbeta * (s[i] * pow(-1,ieh) * xm / xmi + selfi - xnuy);
        double sum;
        if (ek > 50)
            sum = 0;
        else
            sum = w[i] * (fe - fh * (1. - fh)) * s[i];
        temp += sum;
    }
    return xn - 1. / (2 * pi) * temp;
}

double rtbis(double func, double x1, double x2, double xacc) {
    int jmax = 40;
    double ans, dx, xmid;
    double fmid = funci(func, x2);
    double f = funci(func, x1);
    if (f * fmid <= 0) {
        if (f < 0.0) {
            ans = x1;
            dx = x2 - x1;
        } else {
            ans = x2;
            dx = x1 - x2;
        }
        for (int j = 1; j <= jmax; j++) {
            dx = dx * .5;
            xmid = ans + dx;
            fmid = funci(func, xmid);
            if (fmid <= 0.)
                ans = xmid;
            if ((fabs(dx) < xacc) || (fmid == 0.))
                return ans;
        }
    }
    cout << "root must be bracketed in rtbis" << endl;
    exit(1);
}

void gauleg(double x1, double x2, vector < double > & t, vector < double > & w) {
    int m = (n + 1) / 2;
    double xm = 0.5 * (x2 + x1);
    double xl = 0.5 * (x2 - x1);
    double eps = 3.0e-14;
    for (int i = 1; i <= m; i++) {
        double pp, z1, z = cos(pi * (i - .25) / (n + .5));
        do {
            double p1 = 1.0;
            double p2 = 0.0;
            for (int j = 1; j <= n; j++) {
                double p3 = p2;
                p2 = p1;
                p1 = ((2.0 * j - 1.0) * z * p2 - (j - 1.0) * p3) / j;
            }
            pp = n * (z * p1 - p2) / (z * z - 1.0);
            z1 = z;
            z = z1 - p1 / pp;
        } while (abs(z - z1) > eps);
        t[i] = xm - xl * z;
        t[n + 1 - i] = xm + xl * z;
        w[i] = 2.0 * xl / ((1.0 - z * z) * pp * pp);
        w[n + 1 - i] = w[i];
    }
}

void chgvar() {
    vector < double > z(n), v(n);
    gauleg(0., 1., z, v); //gauleg(0, 1, z, v);
    double alpha = 0.5;
    for (int i = 1; i <= n; i++) {
        s[i] = alpha * z[i] / (1. - z[i] * z[i]);
        w[i] = v[i] * alpha * (z[i] * z[i] + 1.) / (z[i] * z[i] - 1.) / (z[i] * z[i] - 1.);
    }
}

double fermi(double x, double ieh) {
    double emu = nbeta * (x - xnue * (1 - ieh) + xnuh * ieh);
    //double emu = nbeta * (x* pow(-1,ieh) - xnue * (1 - ieh) - xnuh * ieh);
    if (emu > 50)
        return 0;
    else
        return 1. / (exp(emu) + 1.);
}

void xeh() {
    double xie = 0, xih = 0;
    for (int i = 1; i <= n; i++) {
        double fei = fermi(abs(s[i]) * xm / xme, 0);
        double fhi = fermi(abs(s[i]) * xm / xmh, 1);
        xie = xie + w[i] * fei * (1. - fei);
        xih = xih + w[i] * fhi * (1. - fhi) * (1. - fhi * (1. - fhi));
    }
    xie = 1 / (2. * pi) * xie;
    xih = 1 / (2. * pi) * xih;
    xieh = xie + xih;
}
// cac ham ellip
double rf(double x, double y, double z) {
    double ERRTOL = 0.0025, THIRD = 1.0 / 3.0, C1 = 1.0 / 24.0, C2 = 0.1,
        C3 = 3.0 / 44.0, C4 = 1.0 / 14.0;
    double TINY = 1.5e-38,
        BIG = 3.E-37;
    double alamb, ave, delx, dely, delz, e2, e3, sqrtx, sqrty, sqrtz, xt, yt, zt;
    if (min(min(x, y), z) < 0.0 || min(min(x + y, x + z), y + z) < TINY ||
        max(max(x, y), z) > BIG);
    xt = x;
    yt = y;
    zt = z;
    do {
        sqrtx = sqrt(xt);
        sqrty = sqrt(yt);
        sqrtz = sqrt(zt);
        alamb = sqrtx * (sqrty + sqrtz) + sqrty * sqrtz;
        xt = 0.25 * (xt + alamb);
        yt = 0.25 * (yt + alamb);
        zt = 0.25 * (zt + alamb);
        ave = THIRD * (xt + yt + zt);
        delx = (ave - xt) / ave;
        dely = (ave - yt) / ave;
        delz = (ave - zt) / ave;
    } while (max(max(abs(delx), abs(dely)), abs(delz)) > ERRTOL);
    e2 = delx * dely - delz * delz;
    e3 = delx * dely * delz;
    return (1.0 + (C1 * e2 - C2 - C3 * e3) * e2 + C4 * e3) / sqrt(ave);
}
double rd(double x, double y, double z) {
    double ERRTOL = 0.0015, C1 = 3.0 / 14.0, C2 = 1.0 / 6.0, C3 = 9.0 / 22.0,
        C4 = 3.0 / 26.0, C5 = 0.25 * C3, C6 = 1.5 * C4;
    double TINY = 1.5e-38, BIG = 3.E-37;
    double alamb, ave, delx, dely, delz, ea, eb, ec, ed, ee, fac, sqrtx, sqrty,
    sqrtz, sum, xt, yt, zt;
    if (min(x, y) < 0.0 || min(x + y, z) < TINY || max(max(x, y), z) > BIG);
    xt = x;
    yt = y;
    zt = z;
    sum = 0.0;
    fac = 1.0;
    do {
        sqrtx = sqrt(xt);
        sqrty = sqrt(yt);
        sqrtz = sqrt(zt);
        alamb = sqrtx * (sqrty + sqrtz) + sqrty * sqrtz;
        sum += fac / (sqrtz * (zt + alamb));
        fac = 0.25 * fac;
        xt = 0.25 * (xt + alamb);
        yt = 0.25 * (yt + alamb);
        zt = 0.25 * (zt + alamb);
        ave = 0.2 * (xt + yt + 3.0 * zt);
        delx = (ave - xt) / ave;
        dely = (ave - yt) / ave;
        delz = (ave - zt) / ave;
    } while (max(max(abs(delx), abs(dely)), abs(delz)) > ERRTOL);
    ea = delx * dely;
    eb = delz * delz;
    ec = ea - eb;
    ed = ea - 6.0 * eb;
    ee = ed + ec + ec;
    return 3.0 * sum + fac * (1.0 + ed * (-C1 + C5 * ed - C6 * delz * ee) +
        delz * (C2 * ee + delz * (-C3 * ec + delz * C4 * ea))) / (ave * sqrt(ave));
}
double rc(double x, double y) {
    double ERRTOL = 0.0012, THIRD = 1.0 / 3.0, C1 = 0.3, C2 = 1.0 / 7.0,
        C3 = 0.375, C4 = 9.0 / 22.0;
    double TINY = 1.5e-38,
        BIG = 3.E-37, COMP1 = 2.236 / sqrt(TINY),
        COMP2 = sqrt(TINY * BIG) / 25.0;
    double alamb, ave, s, w, xt, yt;
    if (x < 0.0 || y == 0.0 || (x + abs(y)) < TINY || (x + abs(y)) > BIG ||
        (y < -COMP1 && x > 0.0 && x < COMP2));
    if (y > 0.0) {
        xt = x;
        yt = y;
        w = 1.0;
    } else {
        xt = x - y;
        yt = -y;
        w = sqrt(x) / sqrt(xt);
    }
    do {
        alamb = 2.0 * sqrt(xt) * sqrt(yt) + yt;
        xt = 0.25 * (xt + alamb);
        yt = 0.25 * (yt + alamb);
        ave = THIRD * (xt + yt + yt);
        s = (yt - ave) / ave;
    } while (abs(s) > ERRTOL);
    return w * (1.0 + s * s * (C1 + s * (C2 + s * (C3 + s * C4)))) / sqrt(ave);
}

double rj(double x, double y, double z, double p) {
    double ERRTOL = 0.0015, C1 = 3.0 / 14.0, C2 = 1.0 / 3.0, C3 = 3.0 / 22.0,
        C4 = 3.0 / 26.0, C5 = 0.75 * C3, C6 = 1.5 * C4, C7 = 0.5 * C2, C8 = C3 + C3;
    double TINY = pow(5.0 * numeric_limits < double > ::min(), 1. / 3.),
        BIG = 0.3 * pow(0.2 * numeric_limits < double > ::max(), 1. / 3.);
    double a, alamb, alpha, ans, ave, b, beta, delp, delx, dely, delz, ea, eb, ec, ed, ee,
    fac, pt, rcx, rho, sqrtx, sqrty, sqrtz, sum, tau, xt, yt, zt;
    if (min(min(x, y), z) < 0.0 || min(min(x + y, x + z), min(y + z, abs(p))) < TINY ||
        max(max(x, y), max(z, abs(p))) > BIG);
    sum = 0.0;
    fac = 1.0;
    if (p > 0.0) {
        xt = x;
        yt = y;
        zt = z;
        pt = p;
    } else {
        xt = min(min(x, y), z);
        zt = max(max(x, y), z);
        yt = x + y + z - xt - zt;
        a = 1.0 / (yt - p);
        b = a * (zt - yt) * (yt - xt);
        pt = yt + b;
        rho = xt * zt / yt;
        tau = p * pt / yt;
        rcx = rc(rho, tau);
    }
    do {
        sqrtx = sqrt(xt);
        sqrty = sqrt(yt);
        sqrtz = sqrt(zt);
        alamb = sqrtx * (sqrty + sqrtz) + sqrty * sqrtz;
        alpha = sqrt(pt * (sqrtx + sqrty + sqrtz) + sqrtx * sqrty * sqrtz);
        beta = pt * sqrt(pt + alamb);
        sum += fac * rc(alpha, beta);
        fac = 0.25 * fac;
        xt = 0.25 * (xt + alamb);
        yt = 0.25 * (yt + alamb);
        zt = 0.25 * (zt + alamb);
        pt = 0.25 * (pt + alamb);
        ave = 0.2 * (xt + yt + zt + pt + pt);
        delx = (ave - xt) / ave;
        dely = (ave - yt) / ave;
        delz = (ave - zt) / ave;
        delp = (ave - pt) / ave;
    } while (max(max(abs(delx), abs(dely)),
            max(abs(delz), abs(delp))) > ERRTOL);
    ea = delx * (dely + delz) + dely * delz;
    eb = delx * dely * delz;
    ec = delp * delp;
    ed = ea - 3.0 * ec;
    ee = eb + 2.0 * delp * (ea - ec);
    ans = 3.0 * sum + fac * (1.0 + ed * (-C1 + C5 * ed - C6 * ee) + eb * (C7 + delp * (-C8 + delp * C4)) +
        delp * ea * (C2 - delp * C3) - C2 * delp * ec) / (ave * sqrt(ave));
    if (p <= 0.0) ans = a * (b * ans + 3.0 * (rcx - rf(xt, yt, zt)));
    return ans;
}

// ham elliptic E(pi/2,x)
double ellf(double ak) {
    return rf(0., abs((1.0 - ak) * (1.0 + ak)), 1.0);
}

// ham elliptic E1(pi/2,n=1,x)

double ellpi(double ak) {
    double cc, enss, q, s, phi, en;
    phi = 3.14156 / 2;
    en = 0.;
    s = sin(phi);
    enss = en * s * s;
    cc = sqrt(cos(phi));
    q = (1.0 - s * ak) * (1.0 + s * ak);
    return s * (rf(cc, abs(q), 1.0) - enss * rj(cc, abs(q), 1.0, 1.0 + enss) / 3.0);
}
// đang sửa
double vjj(double q) {
    double x = q;
    return 12.5 * ellf(x);
}

double exe(double p, double q) {
    double x = q * q;
    double y = 4. / (1. / p + 1. / q);
    double fe = fermi(abs(q) * xm / xme, 0);
    return -vjj(y) * (1 - x) * (exp(-x)) * q * fe / abs(p + q);
}

double veh(double q) {
    return -vjj(q);
}

double wpl(double q) {
    return sqrt(2. * xn * q * q * vjj(q));
}

double wq(double q) {
    return sqrt(pow(wpl(q), 2) + 2. * xn * q * q / (nbeta * xieh) + pow(q, 4));
}

double g(double x) {
    double amu = nbeta * x;
    if (amu > 50)
        return 0;
    else
        return 1. / (exp(amu) - 1.);
}

double core(double p, double q) {
    double eps = dam;
    double ei = p * p * xm / xme;
    double ej = (p - q) * (p - q) * xm / xme;
    double fe = fermi(ei, 0);
    double wwq = wq(q);
    double gg = g(wwq);
    return vjj(q) * pow(wpl(q), 2) / (2. * wwq) * ((1. + gg - fe) / (pow(ei - ej - wwq, 2) + eps * eps) * (ei - ej - wwq) + (gg + fe) / (pow(ei - ej + wwq, 2) + eps * eps) * (ei - ej + wwq));
}

double exh(double p, double q) {
    double x = q * q;
    double y = 4. / (1. / q + 1. / p);
    double fh = fermi(abs(q) * xm / xme, 1);
    return -vjj(y) * (2. - x) * (exp(-x)) * q * fh * (1. - fh) / abs(p + q);
}

double corh(double p, double q) {
    double eps = dam;
    double ei = p * p * xm / xmh;
    double ej = (p - q) * (p - q) * xm / xmh;
    double fh = fermi(ei, 1);
    double wwq = wq(q);
    double gg = g(wwq);
    return vjj(q) * pow(wpl(q), 2) / (2. * wwq) * ((1. + gg - fh) / (pow(ei - ej - wwq, 2) + eps * eps) * (ei - ej - wwq) + (gg + fh) / (pow(ei - ej + wwq, 2) + eps * eps) * (ei - ej + wwq));
}

double xime(double p, double q) {
    double eps = dam;
    double ei = p * p * xm / xme;
    double ej = (p - q) * (p - q) * xm / xme;
    double fe = fermi(ej, 0);
    double wwq = wq(q);
    double gg = g(wwq);
    return vjj(q) * pow(wpl(q), 2) / (2. * wwq) * ((1. + gg - fe) / (pow(ei - ej - wwq, 2) + eps * eps) * (ei - ej - wwq) + (gg + fe) / (pow(ei - ej + wwq, 2) + eps * eps) * (ei - ej + wwq));
}

double ximh(double p, double q) {
    double eps = dam;
    double ei = p * p * xm / xmh;
    double ej = (p - q) * (p - q) * xm / xmh;
    double fh = fermi(ej, 1);
    double wwq = wq(q);
    double gg = g(wwq);
    return vjj(q) * pow(wpl(q), 2) / (2. * wwq) * ((1. + gg - fh) / (pow(ei - ej - wwq, 2) + eps * eps) * (ei - ej - wwq) + (gg + fh) / (pow(ei - ej + wwq, 2) + eps * eps) * (ei - ej + wwq));
}

double core0(double q) {
    double ee = q * q * xm / xme;
    double fe = fermi(ee, 0);
    double wwq = wq(q);
    double gg = g(wwq);
    return vjj(q) * pow(wpl(q), 2) / (2. * wwq) * ((1. + gg - fe) / (pow(ee - wwq, 2) + dam * dam) * (ee - wwq) + (gg + fe) / (pow(ee + wwq, 2) + dam * dam) * (ee + wwq));
}

double corh0(double q) {
    double ee = q * q * xm / xmh;
    double fh = fermi(ee, 1);
    double wwq = wq(q);
    double gg = g(wwq);
    return vjj(q) * pow(wpl(q), 2) / (2. * wwq) * ((1. + gg - fh) / (pow(ee - wwq, 2) + dam * dam) * (ee - wwq) + (gg + fh) / (pow(ee + wwq, 2) + dam * dam) * (ee + wwq));
}

void se() {
    for (int i = 1; i <= n; i++) {
        double sum1 = 0, sum2 = 0, sum3 = 0;
        for (int j = 1; j <= n; j++) {
            sum1 += w[j] * (exe(s[i], s[j]) + 0 * core(s[i], s[j]));
            sum2 += w[j] * (exh(s[i], s[j]) + 0 * corh(s[i], s[j]));
            sum3 += w[j] * (xime(s[i], s[j]) + ximh(s[i], s[j]));
        }
        selfe[i] = 1. / (2 * pi) * sum1;
        selfh[i] = 1. / (2 * pi) * sum2;
        gammb[i] = 1. / (2 * pi) * sum3;
    }
    double sum1 = 0, sum2 = 0, sum3 = 0;
    for (int j = 1; j <= n; j++) {
        sum1 += w[j] * (exe(0.0, s[j]) + 0 * core0(s[j]));
        sum2 += sum2 + w[j] * (exh(0.0, s[j]) + 0 * corh0(s[j]));
    }
}

void susz(double & hw, vector < complex < double >> & sz) {
    double idx, eei, ehi, fei, fhi, resz, aisz;
    if (idx == 0)
        for (int i = 1; i <= n; i++) {
            eei = abs(s[i]) * xm / xme + selfe[i];
            ehi = abs(s[i]) * xm / xmh - selfh[i];
            fei = fermi(eei, 0);
            fhi = (1. - fermi(ehi, 1)) * fermi(ehi, 1);
            resz = (hw - eei - ehi) * (fei + fhi - 1.) / ((hw - eei - ehi) * (hw - eei - ehi) + dam * dam);
            aisz = (1. - fei - fhi) * dam / ((hw - eei - ehi) * (hw - eei - ehi) + dam * dam);
            sz[i].real(resz);
            sz[i].imag(aisz);
        }
    else if (idx == 1)
        for (int i = 1; i <= n; i++) {
            eei = abs(s[i]) * xm / xme + selfe[i];
            ehi = abs(s[i]) * xm / xmh - selfh[i];
            fei = fermi(eei, 0);
            fhi = (1. - fermi(ehi, 1)) * fermi(ehi, 1);
            resz = (hw - eei - ehi) * (fei + fhi - 1.) / ((hw - eei - ehi) * (hw - eei - ehi) + dam * dam);
            aisz = (1. - fei - fhi) * dam / ((hw - eei - ehi) * (hw - eei - ehi) + dam * dam);
            sz[i].real(resz);
            sz[i].imag(aisz);
        }
}

void vsm(vector < vector < complex < double >>> & xv, double & hw) {
    complex < double > ss;
    vector < double > t(8, 0), ares(8, 0), aims(8, 0);
    for (int i = 1; i <= n; i++)
        for (int j = 1; j <= n; j++) {
            if (j == i)
                xv[i][j] = {
                    0.0,
                    0.0
                };
            else {
                double eei = abs(s[i]) * xm / xme + selfe[i];
                double ehi = abs(s[i]) * xm / xmh - selfh[i];
                double eej = abs(s[j]) * xm / xme + selfe[j];
                double ehj = abs(s[j]) * xm / xmh - selfh[j];
                // double eei = s[i] * xm / xme + selfe[i];
                // double ehi = s[i] * xm / xmh + selfh[i];
                // double eej = s[j] * xm / xme + selfe[j];
                // double ehj = s[j] * xm / xmh + selfh[j];
                double fei = fermi(eei, 0);
                double fej = fermi(eej, 0);
                double fhi = (1. - fermi(ehi, 1)) * fermi(ehi, 1);
                double fhj = (1. - fermi(ehj, 1)) * fermi(ehj, 1);
                double anehi = 1.0 - fei - fhi;
                double anehj = 1.0 - fej - fhj;
                double sij = s[i] - s[j];
                double sij1 = 4. / (1. / s[i] + 1. / s[j]);
                double vveh = veh(sij1) / abs(s[i] + s[j]) * (1 - s[i] * s[i]) * (exp(-s[i] * s[i])) * s[i];
                double wwpl = wpl(sij);
                double wwq = wq(sij);
                double gg = g(wwq);
                double gam = 0.5;
                t[1] = -(gg + fej) * (fei - fermi(eej - wwq, 0)) / (eei - eej + wwq);
                t[2] = -(1 + gg - fej) * (fei - fermi(eej + wwq, 0)) / (eei - eej - wwq);
                t[3] = -(gg + fhj) * (fhi - fermi(ehj - wwq, 1)) / (ehi - ehj + wwq);
                t[4] = -(1 + gg - fhj) * (fhi - fermi(ehj + wwq, 1)) / (ehi - ehj - wwq);
                t[5] = -(gg + fej) * (fermi(eej - wwq, 0) + fhi - 1);
                t[5] /= ((hw - eej - ehi + wwq) * (hw - eej - ehi + wwq) + gam * gam);
                ares[5] = t[5] * (hw - eej - ehi + wwq);
                aims[5] = -t[5] * gam;
                t[6] = -(1 + gg - fej) * (fermi(eej + wwq, 0) + fhi - 1);
                t[6] /= ((hw - eej - ehi - wwq) * (hw - eej - ehi - wwq) + gam * gam);
                ares[6] = t[6] * (hw - eej - ehi - wwq);
                aims[6] = -t[6] * gam;
                t[7] = -(gg + fhj) * (fei + fermi(ehj - wwq, 1) - 1);
                t[7] = t[7] / ((hw - eei - ehj + wwq) * (hw - eei - ehj + wwq) + gam * gam);
                ares[7] = t[7] * (hw - eei - ehj + wwq);
                aims[7] = -t[7] * gam;
                t[8] = -(1 + gg - fhj) * (fei + fermi(ehj + wwq, 1) - 1) / ((hw - eei - ehj - wwq) * (hw - eei - ehj - wwq) + gam * gam);
                ares[8] = t[8] * (hw - eei - ehj - wwq);
                aims[8] = -t[8] * gam;
                double aress = 1. / (anehi * anehj) * wwpl * wwpl / (2 * wwq) * (t[1] + t[2] + t[3] + t[4] + ares[5] + ares[6] + ares[7] + ares[8]);
                double aimss = 1. / (anehi * anehj) * wwpl * wwpl / (2 * wwq) * (aims[5] + aims[6] + aims[7] + aims[8]);
                ss = {
                    aress,
                    0 * aimss
                };
                xv[i][j] = vveh * (ss * 0. + 1.);
            }
        }
    ofstream vsmfile("vsm.txt");
    for (int j = 1; j <= n; j++)
        if (j != n / 2)
            vsmfile << s[j] << " " << vjj(s[n / 2] - s[j]) << " " << -real(xv[n / 2][j]) << endl;
}

void xxx(vector < complex < double >> & sz, vector < vector < complex < double >>> & xv, vector < vector < complex < double >>> & xa, vector < complex < double >> & y) {
    for (int i = 1; i <= n; i++) {
        y[i] = sz[i];
        for (int j = 1; j <= n; j++)
            if (i == j)
                xa[i][j] = {
                    1,
                    0
                };
            else
                xa[i][j] = complex < double > (0, 0) + 1. / (2 * pi) * sz[i] * w[j] * xv[i][j];
    }
}

void lud(vector < vector < complex < double >>> & ax) {
    complex < double > sum;
    for (int j = 1; j <= n; j++) {
        for (int i = 1; i <= j; i++) {
            sum = ax[i][j];
            for (int k = 1; k <= i - 1; k++)
                sum = sum - ax[i][k] * ax[k][j];
            ax[i][j] = sum;
        }
        for (int i = j + 1; i <= n; i++) {
            sum = ax[i][j];
            for (int k = 1; k <= j - 1; k++)
                sum = sum - ax[i][k] * ax[k][j];
            sum = sum / ax[j][j];
            ax[i][j] = sum;
        }
    }
}

void luge(vector < vector < complex < double >>> & ax, vector < complex < double >> & b) {
    complex < double > sum;
    for (int i = 1; i <= n; i++) {
        sum = b[i - 1];
        for (int j = 1; j <= i - 1; j++)
            sum = sum - ax[i - 1][j - 1] * b[j - 1];
        b[i - 1] = sum;
    }
    for (int i = n; i >= 1; i--) {
        sum = b[i - 1];
        for (int j = i + 1; j <= n; j++)
            sum = sum - ax[i - 1][j - 1] * b[j - 1];
        b[i - 1] = sum / ax[i - 1][i - 1];
    }
}

void run(double & x1, double & x2, int & m, vector < double > & xw, vector < double > & aimsus, vector < double > & aresus) {
    complex < double > sum, susc;
    vector < complex < double >> sz(nmax), vec(nmax);
    vector < vector < complex < double >>> xv(nmax, vector < complex < double >> (nmax)), xa(nmax, vector < complex < double >> (nmax));
    double hw = x1, step = (x2 - x1) / m;
    for (int k = 1; k <= m + 1; k++) {
        xw[k] = hw;
        susz(hw, sz);
        vsm(xv, hw);
        xxx(sz, xv, xa, vec);
        lud(xa);
        luge(xa, vec);
        sum = 0;
        for (int i = 1; i <= n; i++)
            sum += w[i] * vec[i];
        susc = 1. / (2 * pi) * sum;
        aimsus[k] = imag(susc);
        aresus[k] = real(susc);
        // cout << xw[k] << " " << aimsus[k] << endl;
        hw += step;
    }
}

int main() {
    double tem, x1, x2;
    int m;
    vector < double > hw(mmax), ab(mmax), re(mmax);
    string outfile;
    // cout << "Harmonic frequency (in Rydberg):";
    // cin >> omega;
    omega = 10;
    // cout << "Damping rate (in Rydberg):";
    // cin >> dam;
    dam = 0.5;
    // cout << "Plasma density (in 1 / Bohr radius):";
    // cin >> xn;
    xn = 2;
    // cout << "Temperature (K):";
    // cin >> tem;
    tem = 300;
    // cout << "Gaussian point number (max2000):";
    // cin >> n;
    n = 30;
    // cout << "Output filename:";
    // cin >> outfile;
    //int nstar = 1
    //double B = 2 or 6 or 12
    outfile = "test.txt";
    // cout << "hw-Eg: min  max  step_number(max200)";
    // cin >> x1 >> x2 >> m;
    x1 = -10.0, x2 = 10.0, m = 1;
    xme = 1., xmh = 1.; //xme = 0.67, xmh = 0.4, xm = sqrt(abs(nstar)*B); <Change Here>
    xm = sqrt(6); //xme * xmh / (xme + xmh);
    double e0 = 4.6;
    nbeta = e0 / (0.0862 * tem);
    for (int i = 1; i <= n; i++) {
        selfe[i] = 0;
        selfh[i] = 0;
    }
    chgvar();
    // Chemical potential:
    xnue = rtbis(0, -1.0e+02, 1.0e+02, 1.0e-6);
    xnuh = rtbis(1, -1.0e+02, 1.0e+02, 1.0e-6);
    cout << "Chemical potential: " << xnue + xnuh << endl;
    //cout << "eliptic: " <<rf(0, 0.3, 1.)<< endl;
    // Renormalized chemical potential:
    xeh();
    se();
    xnue = rtbis(0, -1.0e+02, 1.0e+02, 1.0e-6);
    xnuh = rtbis(1, -1.0e+02, 1.0e+02, 1.0e-6);
    double xnu = xnue + xnuh;
    cout << "Renormalized chemical potential: " << xnu << endl;
    cout << "BGR:" << selfe[n / 2] + selfh[n / 2] << endl;
    cout << "gamma:" << gammb[n / 2] << endl;
    run(x1, x2, m, hw, ab, re);
    ofstream ofile(outfile);
    ofile << "omega=" << omega << "; dam=" << dam << "; tem=" << tem << "; xn=" << xn << endl;
    ofstream kq("kq.txt");
    for (int i = 1; i <= m + 1; i++) {
        double em = g(hw[i] - xnu) * ab[i];
        ofile << hw[i] << " " << re[i] << " " << ab[i] << " " << em << endl;
        kq << hw[i] << " " << em << endl;
    }
    ofstream sefile("se.txt");
    for (int i = 1; i <= n; i++)
        sefile << s[i] << " " << selfe[i] + selfh[i] << " " << gammb[i] << endl;
}